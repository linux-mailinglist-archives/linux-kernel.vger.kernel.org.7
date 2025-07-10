Return-Path: <linux-kernel+bounces-726432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D18B00D12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075B43A7D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24D306DD9;
	Thu, 10 Jul 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHlkjm/X"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176B306DB1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179141; cv=none; b=FXGgnJiYXqHNeROtX9I3GzQoMy5zMFz0/SVJ1YVgdY4h6HhgDUOrLAZFQjPSRdqrJk4Ai4M4Q+5gLMMMGy3nIKnc/Ai8lsrVt1OYXW0niFWf6758s4U2JOpBzwrK/NuTeGNzKzE1l+vNnakEsjPM3w+89pESt/24KHMqNf7uKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179141; c=relaxed/simple;
	bh=WFS1g6kYY+XgrAAa5iSXxbIVXwge/aB1XoG8Q1Q1zEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ju07CU7uFXr37q3Eg2JkW3xx9/2O6sjm8TKL0HBhvxJ+clu9F2O+cPcUsb/VcUt+ZUB68bt/2X2dA5iy7B6Ur1T5PZgpVI83bZ6VcbgQmNgpDM2uQ7frAvFflV5aR0wKddZwHlOPpHkvM5ytOu0oHZHrBrhojvkC8Zb9x3EUWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHlkjm/X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b38ffb62492so1569692a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179140; x=1752783940; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLmmHKES778Ih0J3i1L0ZkfJuaKP4hpTsElytjjdQfs=;
        b=KHlkjm/X5phLhyX7I1q/rihXyDgXNMz7gr42FWaE9jz6+X9xlKRv/DWItvkMsahS0E
         xx39SmnR2th1fmFr5ekOi/uSd2LItbnuzDLqMjCZXmeiG8RDM8IvRBNJrP+O21hr/UeS
         T2WE14vK2MFHNIreBpfvx/lhUEFS/OeFC3gOdqDpQEFon5zLDJUEhx36Sv1iYFqt5ggF
         0icJnMdpaF7v0lKk+Z03vyP5H2+kmqvMKrP0Mb5TQVZ865Kda8P8oaoxyiM/dJfId4KQ
         0fPfEPANbmEz0kRsC1Nm4OaiDP3lWAkgxnsgUmPpeOYZQesSQMVTlZJZBwVNjArIHxUX
         Aa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179140; x=1752783940;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLmmHKES778Ih0J3i1L0ZkfJuaKP4hpTsElytjjdQfs=;
        b=GJrrm5ZNKJKG/6pqWKKEQ8/9LQxNcTBbplFFOBmjU54BAgqeES/FIdLiZze1mtb8h2
         GjJz1BA1ufUgY1M/Sv9zVqJHTqDmej3rFYERWndHK1ToARjsEVgRQWxywyBbjsdZjzSi
         F6HnwI9ZL8ie7CXx7uYQLzVZjymBtLp9Q8P0NYHm0gqk+3/mxh25R4jD1NLhRmpC5ZMZ
         ap6gDPAX6WuOMqF/l922K8PXKXy9E2f+1jTVxhS/fI9XlAL00VINv61frMp5Z8BakjnP
         Sqw4KsHcwLyEtXIAp2bjFM6J9FKnDbyjr2TaxjGUmQMaH3Ggv7h9rEZ3+VSxQGAg0s2h
         G1dA==
X-Forwarded-Encrypted: i=1; AJvYcCVjnoTw8XQPaVwtinXlp3dJLdczmbLQm1cqEPGUrutgjtQFkuY7GNsmI0ecC6AJpu/7MEh2KfpIqT8PgzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJeGS8Wl3MSjsBsoFqF7QLioF5KGSMQ1N+TJej4TAFmUBWAK3
	wOt5JMlAvQsnCprOWL0fxxAjYHVc2k7uSwU+KQfxtpyQ/rsfxm8fNgvFLTR8ZO8a+KbjGnzf2tL
	A5dKiGyaxVQ==
X-Google-Smtp-Source: AGHT+IEjFG/YTY29uA5hJ6qZ0TEChiwCH3/Mq1LeU8SbYbzUA0zgXqfOLwTrlnQOsn68ErSvSK7CsSstUNPX
X-Received: from pfbbk21.prod.google.com ([2002:aa7:8315:0:b0:748:f3b0:4db2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72ab:b0:220:b0dc:24f2
 with SMTP id adf61e73a8af0-231202f28eemr1287735637.34.1752179139740; Thu, 10
 Jul 2025 13:25:39 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:54 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-17-irogers@google.com>
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


