Return-Path: <linux-kernel+bounces-743331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D385B0FD54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860F1AA05EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0612749D1;
	Wed, 23 Jul 2025 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByWB/+m+"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02754274FC8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313000; cv=none; b=YcP/D11FfbrVB7HTvNA1xGq0tYUPULsovW2I1jfDo4hI3U1MwiiJHI0V3LnCBUhq2bus8KF73kwj9nz4Q5ZIFmcaow9D/p7t5Hom06jqEWhopHO8BJERp3xoK0uWZ0QmPhWIzyWt/fVqfc/YPqgKef7DzjOnLQBX5s9Ak4XfDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313000; c=relaxed/simple;
	bh=7W2OwNvCKl5AjDEGsRcKdkWux7FNfF8gWFpHCiwbOTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hGSHQX5Ogncd63uJpKzeH8mi3KaVUvLhTJG+DCdHkOV135HQtT5jIq/A4iYcw1TqfY/+EIisgdvRsK0+RGeypKUrEYfJaqIsUNZ/rx6UbAKUgAmtGeoaZsFOhtmK0yO7nBa9g7e+jQC3SAy38pNs/ECahJC+cMWObbCH5GEqmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByWB/+m+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so258947a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312998; x=1753917798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQX6HKbYgS42p2L0uks7UqDqcpdHxytIA9YuMYrF0ZQ=;
        b=ByWB/+m+3e0EfRFVLROa9m97JajdscK1t9e7EXArnPMjQnq47QvHKmYMJMgVPolZu6
         8tb0oFfrHt8Rz9TFbwp3cEKqA1OAShxHc0z97OS1NkWZ0PCIJJNhj+vmolLDh6VgZbY/
         upO+Yeuy8WTJlcFNqzO8hMWh/NiW33UVt6GfwdJkxkpetbxzDlNsXZC7YGkun5vKW5Ek
         AY5mcNEfurd1F9vbGdPFlG+b/UPmqFCaicuWUd99/I0vat3zK6HZE9sfFBMQsrb2XHe3
         qVpi0hOiOYdtlheoSBNR76Je8RkYx9NN007BN4C8ygj7TZPh8dQ96pUa4Tx87XXoXgHH
         fAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312998; x=1753917798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQX6HKbYgS42p2L0uks7UqDqcpdHxytIA9YuMYrF0ZQ=;
        b=t00LoUjAVfVFjg2qcMz5OYBN0fTWvh1CaDWFInVJJxm4ZrKeqslKJvdg+BaaO0o640
         Y6HoVaw/wWKGWCUCGcsftcK3YwZltlC6OJ8E+5mO5xULtu/SDf8r1P7e5c2lcCNTaUP5
         +Jfhi0nLefVEW8cvrCdPZG24ltU3RUATa8pYQXTw9ab1A7aONIdj0Im3hFQxqtSNCzU5
         If1J95mqxWr74UdSVH5jNgoRY0ozLkN9uoaSDUgSgp6zXRTg6GzaI3vJf2aLsTNFRudh
         VwvzJcG0S4s+cJk2WuKhA0ANI+Bf/NeLvuNex4XWCVFIpWob12t6ZH23E/SZs5a/Akct
         ExFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/dxzf5baUGwOZqXlFZrLzS/SB8zQAHSI0EvdEPiZnAK16lMRauao9JCzhzsTRw5sljcVAAkWle9SDnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8NdEiDd2jBnHS0kbGVn01NRuFM55SiAjB9oX4I4GZFNYU6cT
	+YKEE9jVzNalZrU88J6q1IbUXmI6u+a7MBSQLcyWsq9Huc0N9xrP0LFWOOV07kyeYWuCT5ABIb6
	qlek3wzBzGw==
X-Google-Smtp-Source: AGHT+IGPQ7QbY0ypIIaymwMZ5McrQ2xp90w71N7CCBFAjq64ioImo5NRcvUbrvOuvM8F7hqeZbUr7vGKhlz0
X-Received: from pga3.prod.google.com ([2002:a05:6a02:4f83:b0:b2d:aac5:e874])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a2:b0:238:3f54:78f1
 with SMTP id adf61e73a8af0-23d4916e98dmr7794433637.43.1753312998305; Wed, 23
 Jul 2025 16:23:18 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:11 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-11-irogers@google.com>
Subject: [PATCH v8 10/16] perf python: Add function returning dictionary of
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
2.50.0.727.gbf7dc18ff4-goog


