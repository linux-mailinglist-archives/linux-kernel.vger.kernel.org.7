Return-Path: <linux-kernel+bounces-746230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4025B12456
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825F43B223A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7C62566F5;
	Fri, 25 Jul 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qu9kUaJs"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4532561DD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469554; cv=none; b=P+7Ms0Mwdyh8w1e+yBl7Ix7hocLE/tgRuwhdcxMFrYOQNXy7ST1qgVn8pJZqKTabi37dPiqbV46dRcKgsnXhPqDWErdh+E6bU10dDefiUPwCQIXlcAzbFbUCVyIZjTHmCxY/obKYrIK7Qlm/gTb71DGeHK0qOdV/r8sanlVs1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469554; c=relaxed/simple;
	bh=TEdXz7pmjX/VVGqT+6IAkD79lk9qzvOAigwv0QCzm1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NL9g4MpnJboSX9rGFKOryNDd5XBf9M35BmLbhQtz5quu6VLmoMJ2kpJMEvpp6crQ/zdxYgQ6crSlgGuB38b93hLg3WSoXbUo/oBnEqMD2YUrJsHww+ndfWKuKOLR7AEPR3sgRAJ3IF2RIRix8uWtOIH/ebDLl/MbNVl6rPoi7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qu9kUaJs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e1d66fa6so24218365ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469553; x=1754074353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZYsIecRZJDshqzI/wllN5UafWVm9WY9utPZhWIM3pU=;
        b=Qu9kUaJsBJeWUOTV5bWNr5VbcmP6Ycn6NrwumOSlsVe+uvL/fXrNpyhJYHULLnjfU5
         5oGK54v4uco6VtUemBs1O/Ss/Al8/KGiSRin0PQQCsMrsIwa+R8iqVYH/QJZxv/Ipw+4
         5apP46w2AlwsdybxYioR+wf96cQzskRN6/pswPvBVe5S95H8uizTKFySDsOlRDT9q6pQ
         rxpOCcBNSv2kPVTkiWRNG3XXtjlJoCTGPKfKbEN3iLGcPXYaUy0U9q4RqfkYzOVFvTvx
         RjzcNos5avK0DQe35cWn5ozNvckNBgjQezbB6WjcZswPIzmys5lUeXyYnLf/P2n6KbEY
         2Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469553; x=1754074353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZYsIecRZJDshqzI/wllN5UafWVm9WY9utPZhWIM3pU=;
        b=ovrRgiATcyi22PdOPGNVQP2r9XNYxU6OfgAY9p7dS8GzicEwe64BXEp1rijHpKB+cO
         5M/2CtrRq6FPIbdzfzus1x9ITX78kBiZsNl9uidxokmv7B7O6rJJctxuAMnnNCOI87Cz
         BMsDbzuf/LeSVo+ETARPpZvpp1phM9qyPlab3joLbt6a0cDbEfabltc6BdvceNlVQsf1
         BCiccxwM/VlCTB7SomwAS4nNuswe1E7PybWt8qYQwvkRqdPwetwkUeHBsq/hrI9dZD1x
         BoBeKf94Abg1emu2C+YwkHuUEqGdkAAQDUOLkxsourc9eZjQ4xCSEtj8txd8Z7WqJVvl
         I1WA==
X-Forwarded-Encrypted: i=1; AJvYcCV7VShdUDQeKaKAvI2MINlkZm5jp0eG1Stu+JtAgb59ePtgL6Q36YIVObpW1jg/AbIFAgaJw98HYTGRDO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGGnjbs5XV7dWQzo+bbOJFDROOZTctLZRPFe+lN6Fth+huaKj
	zN3sjalpyPvCca23Mgl2eiCbbIAJamWtCNRK8916iQE5zqlFsbf59lUAQK082qlOyozxtWVQ4y8
	IgGL9kzjZ/g==
X-Google-Smtp-Source: AGHT+IEKlvLcagcimf+HHBXj8vgIqOb3k6bzDPBVgZTJwDjKILapovy/9ACfNqmyU4bwCI8eL7s4Eb7Jv9V+
X-Received: from plpj7.prod.google.com ([2002:a17:903:3d87:b0:23d:dd69:dd07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4c:b0:235:e76c:4353
 with SMTP id d9443c01a7336-23fb31b01a6mr51649805ad.51.1753469552764; Fri, 25
 Jul 2025 11:52:32 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:56 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-11-irogers@google.com>
Subject: [PATCH v9 10/16] perf python: Add function returning dictionary of
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ddcb5d40ff14..d49b4401ab7e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -660,6 +660,71 @@ static PyObject *pyrf_pmu__name(PyObject *self)
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
+	int ret;
+
+	if (!py_list)
+		return NULL;
+
+	ret = perf_pmu__for_each_event(ppmu->pmu,
+				       /*skip_duplicate_pmus=*/false,
+				       py_list,
+				       pyrf_pmu__events_cb);
+	if (ret) {
+		Py_DECREF(py_list);
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return py_list;
+}
+
 static PyObject *pyrf_pmu__repr(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
@@ -670,6 +735,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
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
2.50.1.552.g942d659e1b-goog


