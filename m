Return-Path: <linux-kernel+bounces-726459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7967B00D41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8128E02C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908E30113D;
	Thu, 10 Jul 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxkKd3iX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942272FF476
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179842; cv=none; b=TivormRe5fhDiMIk7gCwq9Aju6H5Vv+QIOdlaOpYA2z9WsYmQVQznhJGDhmn6RehbycOyZ42m78agGudUPQVA3RcDZa4iEGuSmTA0nZxoqIRl/fT8Fu7d7IG8jhP3zmCOdnkcICniGcw6UBrPiHWRxB3tkrEm8BcACsiCp3ZR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179842; c=relaxed/simple;
	bh=WFS1g6kYY+XgrAAa5iSXxbIVXwge/aB1XoG8Q1Q1zEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pVo7CfxD8oYLSA8JEoOHiFq+xRdKTrl7XGNiFcaksj8qCf3wAKeB1KMfwK532x5o3+xv5ykAw2QcIfL477qbeTXJh7De3tfk91RUMdMMyNDdI2w3Cq6/O8p8N3J7EDtKXQYJNBB4OwO089zUc7f55DMNwJbYNgiI1jCDix9ZFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxkKd3iX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so1677370a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179840; x=1752784640; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLmmHKES778Ih0J3i1L0ZkfJuaKP4hpTsElytjjdQfs=;
        b=SxkKd3iXSyrkKyEFhh8MDeyGlFNdiHq9jrhosV7Bz8M7B+lz4xTFBUHTKYgXdCrMmk
         LP39hjuclWp6+2W27tjYt7SOqtGEe76ONmJC/7/5yq3bvtAQmBUHv2Yyk9fKBgYBD/SN
         63KYwNaRAewEP/GiVtRfz///auSfS+YuOqs7KvkT/W2XOBpbD/Cghyto9gkOF9zzch7H
         swJwCVkgPXI2zy0+Za0gzd3Vc2CTEHTmnI10q+TT6Jey7EJuwSRy6LfMtA66651VzdSY
         nBJKY5mQuboftOpoQxGIgoDSpQeyGsPWCcg7T9YfdCzbdppH/5P6uBUg1NnA2ObFwRxH
         a8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179840; x=1752784640;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLmmHKES778Ih0J3i1L0ZkfJuaKP4hpTsElytjjdQfs=;
        b=ch0q9AVUD35vROW09BkJxs5FOfw/oJl8k7/9WTGoVQL+ZT4ejvXHP9BDXhIJAEJHar
         mxqht9pGMtkKMTGv9gqzJVGWByj29tdW2teyQbcjCIwRAfPxC8XcRR93kdXBX8ACgsM0
         lXgEsCTPfRbz5XQzvsLALZE7YM+mgYhxIvOm7U17KwaZrL4rBC/IxBd9rlZzOSOM08fL
         vXvG29ytde8YxUMzJKgx82E954T4rcVEoNrDq0v3MOCTd/og/1zJYPE/55DBpzBsU5vT
         WUhGGKPM1PHQXlg8Q7ThDe0d63zCX53h0frfE/VWjVA1xKnxCIk0GPS3IA+npuHlsWNn
         8zkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd5WemB1S4sqL5/deOoXEboZSN3GqGSaPwQi14bMSZklPpPDM/+UtXukCGQISeLCeEQMGF2xzDaYU9l9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbl0KbC0LcX1uJrbGiml3bWu7FvSnTuRL4gsZ+sNrLBjELwYC/
	Ar66gRkEoCzb5y/zrlpqh3xE60rCbe9tmmGf8ZlSkCA3G+BjOXstOO1GN/MdREn4aZG+geO/ZJ3
	pboV5rjUinA==
X-Google-Smtp-Source: AGHT+IG66RLAamfdtlHykoWDuHT9pngW3hxA+XM+hCRXOVw+x50fSgsfw3tonkScwjdg82U82dx+zEn7RaDD
X-Received: from plas9.prod.google.com ([2002:a17:903:2009:b0:234:c5eb:fe1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da2d:b0:235:eefe:68f4
 with SMTP id d9443c01a7336-23dede7d480mr8158925ad.29.1752179839979; Thu, 10
 Jul 2025 13:37:19 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:50 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-9-irogers@google.com>
Subject: [PATCH v5 08/14] perf python: Add function returning dictionary of
 all events on a PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow all events on a PMU to be gathered, similar to how perf list
gathers event information.

An example usage:
```
$ python
Python 3.12.9 (main, Feb  5 2025, 01:31:18) [GCC 14.2.0] on linux
>>> import perf
>>> for pmu in perf.pmus():
...   print(pmu.events())
...
[{'name': 'mem_load_retired.l3_hit', 'desc': 'Retired load instructions...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0124db5ab3d1..728ed27986b5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -649,6 +649,67 @@ static PyObject *pyrf_pmu__name(PyObject *self)
 	return PyUnicode_FromString(ppmu->pmu->name);
 }
 
+static bool add_to_dict(PyObject *dict, const char *key, const char *value)
+{
+	PyObject *pkey, *pvalue;
+	bool ret;
+
+	if (value == NULL)
+		return true;
+
+	pkey = PyUnicode_FromString(key);
+	pvalue = PyUnicode_FromString(value);
+
+	ret = pkey && pvalue && PyDict_SetItem(dict, pkey, pvalue) == 0;
+	Py_XDECREF(pkey);
+	Py_XDECREF(pvalue);
+	return ret;
+}
+
+static int pyrf_pmu__events_cb(void *state, struct pmu_event_info *info)
+{
+	PyObject *py_list = state;
+	PyObject *dict = PyDict_New();
+
+	if (!dict)
+		return -ENOMEM;
+
+	if (!add_to_dict(dict, "name", info->name) ||
+	    !add_to_dict(dict, "alias", info->alias) ||
+	    !add_to_dict(dict, "scale_unit", info->scale_unit) ||
+	    !add_to_dict(dict, "desc", info->desc) ||
+	    !add_to_dict(dict, "long_desc", info->long_desc) ||
+	    !add_to_dict(dict, "encoding_desc", info->encoding_desc) ||
+	    !add_to_dict(dict, "topic", info->topic) ||
+	    !add_to_dict(dict, "event_type_desc", info->event_type_desc) ||
+	    !add_to_dict(dict, "str", info->str) ||
+	    !add_to_dict(dict, "deprecated", info->deprecated ? "deprecated" : NULL) ||
+	    PyList_Append(py_list, dict) != 0) {
+		Py_DECREF(dict);
+		return -ENOMEM;
+	}
+	Py_DECREF(dict);
+	return 0;
+}
+
+static PyObject *pyrf_pmu__events(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+	PyObject *py_list = PyList_New(0);
+
+	if (!py_list)
+		return NULL;
+
+	if (perf_pmu__for_each_event(ppmu->pmu,
+				     /*skip_duplicate_pmus=*/false,
+				     py_list,
+				     pyrf_pmu__events_cb) != 0) {
+		Py_DECREF(py_list);
+		return NULL;
+	}
+	return py_list;
+}
+
 static PyObject *pyrf_pmu__repr(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
@@ -659,6 +720,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
 static const char pyrf_pmu__doc[] = PyDoc_STR("perf Performance Monitoring Unit (PMU) object.");
 
 static PyMethodDef pyrf_pmu__methods[] = {
+	{
+		.ml_name  = "events",
+		.ml_meth  = (PyCFunction)pyrf_pmu__events,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Name of the PMU including suffixes.")
+	},
 	{
 		.ml_name  = "name",
 		.ml_meth  = (PyCFunction)pyrf_pmu__name,
-- 
2.50.0.727.gbf7dc18ff4-goog


