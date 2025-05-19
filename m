Return-Path: <linux-kernel+bounces-654422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A5ABC809
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 21:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE7A4A436A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 19:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD338217709;
	Mon, 19 May 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWODWSKd"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6B213E78
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684342; cv=none; b=jXXkn5nMruIGrcZAkklwpRR3MbYKFNGHuVrBEjT+SejWrSFLho0vPF05r9DsSlLgtLzxYAH6nfKHD92cbr+e+iO2KHuMw5bqqRco0Dkhh0n15j2JXyTQmg1ep0PLsSbx72BIhPr9NJjGA2rR8t84LTSnDOfo1sSm4N5nWB/jGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684342; c=relaxed/simple;
	bh=Y/HNMqcQP/riAHO3HNhmmDEvvwFHYw87yxhobZtc66U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WsPPT7jVaYX5PHoSm6JaZj8avXhFp0gjmdQAVfOLe8cZxZOgnFFZyXG1lCbE4bhld1w3jh/xOx5clZevGUhB5+ZCng5ciYvqvVj6IOpz5Za7PEDe1jxLFDroQHej7WxCoLqZdNGVEn4/r3ZSbdM9Hx3EQ/4FdOCZxoQG6mlDQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWODWSKd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so5191750a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747684339; x=1748289139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEC8UOjbQB4i9lwjJYkmf0JwtSt5t5y7+0+7oUgRW1Y=;
        b=rWODWSKduHB6Xni6LVNTzGZhrUZnxnzIzeSNEFjMgaHwY0chj64Gh5Pe9plbJNDQCY
         qwivDqZ9ka5LziFd7ECdA3/42cQUG5vZ0kHSVEdnve7BinN8iM9ZdWsDDEeFzcR8JbJf
         +QkEg7VtzBl13rGIhnwloRXKArMHXAdPS8dpA1/+FLyu4YrUPMaWwtTz7gFth6Y9UxVb
         j26G+/fwaLhWutV4IqVZredCQ3Uf07SA7Vgxm6uED4LqPhPz9uJec7HEs2F6UdNjZy+5
         SidmrsuKNN1+2SQNKk9+78oTAxGahwOJjXXeMNoMOzDBF0v69yCZrw+BSfaRSC1nPJNX
         /vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684339; x=1748289139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEC8UOjbQB4i9lwjJYkmf0JwtSt5t5y7+0+7oUgRW1Y=;
        b=Cxtsyrp/XtEEKK50ix9VBL79MJ6UyHXmPOxJgrOA6EWHd3+sk5hJwlfqFOWqBfKWJ9
         MOCiG+CpO2Ov7mff10zjdDgZAVS/8EHCurNbUUFnuEg/u/9pnIAIJwNcRri8OZQzeYsm
         r0cgxw2uOAG9jHv+z8hQEt6rckDjV1QrOINEY/CNGAJaPR5VaBrvQ3PjVKJKKQEM1352
         b/UcKybrfCIjaae7VgjWvPgjWx1rf1Su7pXiFdsBrKvjVfOLAH88rrLwHmatODudo/iY
         cHyAVBUgNZwTPT9pYaRsq/fMYU+GpQsBP+c+JCXs0wis9LLiiBSDG86LpPKO1Nwgmt9e
         G+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj9FQVhXsdqcXi+lWcKgK/JwctPFC0TGAsIQnmot3FDkXQ9LaPEKz17Cmb9YB09tXLt+UkeBCCKOglzUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhejjPQ//9HI49nv9cMsP4tBo3xQwE76nY7a+etSvqsAyJLL+
	kRa0saODvpzS10F0t4aTTPcVdsPeLLs0YMXSUrf1eYeh2UtYzAv0n0HQMAxGstYctaVUPKWorbO
	e0aPIpuiSZQ==
X-Google-Smtp-Source: AGHT+IE4wYkkv0WQ++1iJ/s32JMqVqDb/FRQ1CdnxcBr6RgzfW4bFAGJ4ixnmqMEpDnvABzcJCFQELKK7jTZ
X-Received: from pfblr44.prod.google.com ([2002:a05:6a00:73ac:b0:730:7e2d:df69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7287:b0:1f5:8a69:f41b
 with SMTP id adf61e73a8af0-2170ce39a02mr20946344637.37.1747684338812; Mon, 19
 May 2025 12:52:18 -0700 (PDT)
Date: Mon, 19 May 2025 12:51:41 -0700
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519195148.1708988-5-irogers@google.com>
Subject: [PATCH v3 4/7] perf python: Add support for perf_counts_values to
 return counter data
From: Ian Rogers <irogers@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

From: Gautam Menghani <gautam@linux.ibm.com>

Add support for perf_counts_values struct to enable the python
bindings to read and return the counter data.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/python.c | 92 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ead3afd2d996..1cbddfe77c7c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -626,6 +626,92 @@ static int pyrf_thread_map__setup_types(void)
 	return PyType_Ready(&pyrf_thread_map__type);
 }
 
+struct pyrf_counts_values {
+	PyObject_HEAD
+
+	struct perf_counts_values values;
+};
+
+static const char pyrf_counts_values__doc[] = PyDoc_STR("perf counts values object.");
+
+static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values)
+{
+	Py_TYPE(pcounts_values)->tp_free((PyObject *)pcounts_values);
+}
+
+#define counts_values_member_def(member, ptype, help) \
+	{ #member, ptype, \
+	  offsetof(struct pyrf_counts_values, values.member), \
+	  0, help }
+
+static PyMemberDef pyrf_counts_values_members[] = {
+	counts_values_member_def(val, Py_T_ULONG, "Value of event"),
+	counts_values_member_def(ena, Py_T_ULONG, "Time for which enabled"),
+	counts_values_member_def(run, Py_T_ULONG, "Time for which running"),
+	counts_values_member_def(id, Py_T_ULONG, "Unique ID for an event"),
+	counts_values_member_def(lost, Py_T_ULONG, "Num of lost samples"),
+	{NULL}
+};
+
+static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_values *self, void *closure)
+{
+	PyObject *vals = PyList_New(5);
+
+	if (!vals)
+		return NULL;
+	for (int i = 0; i < 5; i++)
+		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));
+
+	return vals;
+}
+
+static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObject *list,
+					 void *closure)
+{
+	Py_ssize_t size;
+	PyObject *item = NULL;
+
+	if (!PyList_Check(list)) {
+		PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
+		return -1;
+	}
+
+	size = PyList_Size(list);
+	for (Py_ssize_t i = 0; i < size; i++) {
+		item = PyList_GetItem(list, i);
+		if (!PyLong_Check(item)) {
+			PyErr_SetString(PyExc_TypeError, "List members should be numbers");
+			return -1;
+		}
+		self->values.values[i] = PyLong_AsLong(item);
+	}
+
+	return 0;
+}
+
+static PyGetSetDef pyrf_counts_values_getset[] = {
+	{"values", (getter)pyrf_counts_values_get_values, (setter)pyrf_counts_values_set_values,
+		"Name field", NULL},
+	{NULL}
+};
+
+static PyTypeObject pyrf_counts_values__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.counts_values",
+	.tp_basicsize	= sizeof(struct pyrf_counts_values),
+	.tp_dealloc	= (destructor)pyrf_counts_values__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_counts_values__doc,
+	.tp_members	= pyrf_counts_values_members,
+	.tp_getset	= pyrf_counts_values_getset,
+};
+
+static int pyrf_counts_values__setup_types(void)
+{
+	pyrf_counts_values__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_counts_values__type);
+}
+
 struct pyrf_evsel {
 	PyObject_HEAD
 
@@ -1475,7 +1561,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evlist__setup_types() < 0 ||
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
-	    pyrf_cpu_map__setup_types() < 0)
+	    pyrf_cpu_map__setup_types() < 0 ||
+	    pyrf_counts_values__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -1520,6 +1607,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_cpu_map__type);
 	PyModule_AddObject(module, "cpu_map", (PyObject*)&pyrf_cpu_map__type);
 
+	Py_INCREF(&pyrf_counts_values__type);
+	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.49.0.1101.gccaa498523-goog


