Return-Path: <linux-kernel+bounces-726458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1CDB00D40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EF61672E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60DE2FF481;
	Thu, 10 Jul 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCb9nc72"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8D2FEE30
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179840; cv=none; b=J5N+5y4wEjeU22fikzYozVEd054PW8XpNBXrbWFYhkoik2ctMS0pVCOJZIwyYqmXT7jYZpsbdpZtvas9LV4sii492aS0ZxvZMeFylNREGwqWwtBSO5xiXks6BPCfUazTtP538cFTbDm//7IQZOJYAtpUWXiA3BqO3ugOjCA9vjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179840; c=relaxed/simple;
	bh=djgGA+2uKhtnV1MR7VzStD3Qsfg+MK7coxDPgG/6gFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qwtE4VWcobuJ10LEtX4xrpm5P1hUs3wESHs51QIRNIEwKRAzsSYhSB10L8goQETnrFNK87uPzc/z7xN8OZ/v7oNphyjbixMSbUg8X8K7qB10GX1O1jwub4S9FfaVTiPlyr3mctlEs25H3wzV2P9lAOXAm1Raqcluumaq78xzlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCb9nc72; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3ba7659210so1043036a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179838; x=1752784638; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U89VxtBTYyWaxU+pAq4vLFW77vwlkptU1zKa/exvlE4=;
        b=jCb9nc72iEtUYO0OYnM9SF0F4ZC9Tr24iqseZC+ZJVgmOQ8Bz1O+9fNrLmwIC/MO2g
         UXhgVE9/s0fuqiYHYRa2/Cw7IDBJ3eiWzgqLkWkEh2Jdi5uC/0CPiOx2zbLHIlpJeqOi
         uObpEvhscXzkDa9/GQFnEzNTOG1wRu3yLRVygmD2ZewEwqyU/bJjeZv9fyxXWPwrQztj
         L+wLx/g4/I06av3X0J1bfgmjzZvIPEbQxDT1P19CJKlowYCdIwZEfU4D8dH6CfRDAisO
         eAD2il21q+CapoMa8tcjILJ7v9YBDKSOPTlJzOWdC0YHLVosLxI800AsxHABrrqF9vLc
         cxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179838; x=1752784638;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U89VxtBTYyWaxU+pAq4vLFW77vwlkptU1zKa/exvlE4=;
        b=ZV2KuvXgU2QRoqCHM84K0GTrQdbWEIMfZLWNwetRxFYLcbmWznLZI0x52+Ql+bqQZ/
         5r0xp85TrRIPyq2bW9DMXNEPkZSndU1+y9+DROLnOgvhBGJQ9p7205gbxi2BnELTJ7vN
         IIX8XTrnfWhPv5jTbMUVSHYT0+E2koO2DZFD205O+68FmWLMJemfykjiKSTaIMMKEk11
         9FwPsgoeNj/EhV/lYcjrmVckbYB4HYn9MJf3glSe2JLYL4cct7sF9xPvp0acOixxp/Xo
         1jI3ZT8rNbtyVFaUjrshZYUrwlHKYBy9XBWpXGtcKZgWqz+BEJ4XODi6a6Le6TWj20Cp
         fCbw==
X-Forwarded-Encrypted: i=1; AJvYcCVmBY4roD0DwPLj4t2ifInQhwqA5AAgnPjDS6k8xJCQhHSpXP02sTybVzOPaW+cQwdlLJKrcIvjDWBB32s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRI4f+77BMBJs38kVTjzQG46RVPLUkt5RpuYbN9PgbYJC/V4T
	IoRinOkrwV7eu9NhNwvuSFs6df/OXQ3ljrfAdpTap0P6S81rk6VixiLijObW85Dvd9cMlw6U0iC
	YJ+n/n8oVWA==
X-Google-Smtp-Source: AGHT+IF5hEPVXNRRl4UtGe5aAM8X29eCVWj+V1zN7tZhiu0tYH4fyRyvGczr0PumXLN3fSfsid8C3cfa1AFi
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:31c:2fe4:33b4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d407:b0:311:ea13:2e63
 with SMTP id 98e67ed59e1d1-31c4f4b80d9mr74141a91.13.1752179837881; Thu, 10
 Jul 2025 13:37:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:49 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-8-irogers@google.com>
Subject: [PATCH v5 07/14] perf python: Add basic PMU abstraction and pmus sequence
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

Add an ability to iterate over PMUs and a basic PMU type then can just
show the PMU's name.

An example usage:
```
$ python
Python 3.12.9 (main, Feb  5 2025, 01:31:18) [GCC 14.2.0] on linux
>>> import perf
>>> list(perf.pmus())
[pmu(cpu), pmu(breakpoint), pmu(cstate_core), pmu(cstate_pkg),
pmu(hwmon_acpitz), pmu(hwmon_ac), pmu(hwmon_bat0),
pmu(hwmon_coretemp), pmu(hwmon_iwlwifi_1), pmu(hwmon_nvme),
pmu(hwmon_thinkpad), pmu(hwmon_ucsi_source_psy_usbc000_0),
pmu(hwmon_ucsi_source_psy_usbc000_0), pmu(i915), pmu(intel_bts),
pmu(intel_pt), pmu(kprobe), pmu(msr), pmu(power), pmu(software),
pmu(tool), pmu(tracepoint), pmu(uncore_arb), pmu(uncore_cbox_0),
pmu(uncore_cbox_1), pmu(uncore_cbox_2), pmu(uncore_cbox_3),
pmu(uncore_cbox_4), pmu(uncore_cbox_5), pmu(uncore_cbox_6),
pmu(uncore_cbox_7), pmu(uncore_clock), pmu(uncore_imc_free_running_0),
pmu(uncore_imc_free_running_1), pmu(uprobe)]
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 140 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ad2437d132f3..0124db5ab3d1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -628,6 +628,138 @@ static int pyrf_thread_map__setup_types(void)
 	return PyType_Ready(&pyrf_thread_map__type);
 }
 
+/**
+ * A python wrapper for perf_pmus that are globally owned by the pmus.c code.
+ */
+struct pyrf_pmu {
+	PyObject_HEAD
+
+	struct perf_pmu *pmu;
+};
+
+static void pyrf_pmu__delete(struct pyrf_pmu *ppmu)
+{
+	Py_TYPE(ppmu)->tp_free((PyObject *)ppmu);
+}
+
+static PyObject *pyrf_pmu__name(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+
+	return PyUnicode_FromString(ppmu->pmu->name);
+}
+
+static PyObject *pyrf_pmu__repr(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+
+	return PyUnicode_FromFormat("pmu(%s)", ppmu->pmu->name);
+}
+
+static const char pyrf_pmu__doc[] = PyDoc_STR("perf Performance Monitoring Unit (PMU) object.");
+
+static PyMethodDef pyrf_pmu__methods[] = {
+	{
+		.ml_name  = "name",
+		.ml_meth  = (PyCFunction)pyrf_pmu__name,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Name of the PMU including suffixes.")
+	},
+	{ .ml_name = NULL, }
+};
+
+/** The python type for a perf.pmu. */
+static PyTypeObject pyrf_pmu__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.pmu",
+	.tp_basicsize	= sizeof(struct pyrf_pmu),
+	.tp_dealloc	= (destructor)pyrf_pmu__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_pmu__doc,
+	.tp_methods	= pyrf_pmu__methods,
+	.tp_str         = pyrf_pmu__name,
+	.tp_repr        = pyrf_pmu__repr,
+};
+
+static int pyrf_pmu__setup_types(void)
+{
+	pyrf_pmu__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_pmu__type);
+}
+
+
+/** A python iterator for pmus that has no equivalent in the C code. */
+struct pyrf_pmu_iterator {
+	PyObject_HEAD
+	struct perf_pmu *pmu;
+};
+
+static void pyrf_pmu_iterator__dealloc(struct pyrf_pmu_iterator *self)
+{
+	Py_TYPE(self)->tp_free((PyObject *) self);
+}
+
+static PyObject *pyrf_pmu_iterator__new(PyTypeObject *type, PyObject *args __maybe_unused,
+					PyObject *kwds __maybe_unused)
+{
+	struct pyrf_pmu_iterator *itr = (void *)type->tp_alloc(type, 0);
+
+	if (itr != NULL)
+		itr->pmu = perf_pmus__scan(/*pmu=*/NULL);
+
+	return (PyObject *) itr;
+}
+
+static PyObject *pyrf_pmu_iterator__iter(PyObject *self)
+{
+	Py_INCREF(self);
+	return self;
+}
+
+static PyObject *pyrf_pmu_iterator__iternext(PyObject *self)
+{
+	struct pyrf_pmu_iterator *itr = (void *)self;
+	struct pyrf_pmu *ppmu;
+
+	if (itr->pmu == NULL) {
+		PyErr_SetNone(PyExc_StopIteration);
+		return NULL;
+	}
+	// Create object to return.
+	ppmu = PyObject_New(struct pyrf_pmu, &pyrf_pmu__type);
+	if (ppmu) {
+		ppmu->pmu = itr->pmu;
+		// Advance iterator.
+		itr->pmu = perf_pmus__scan(itr->pmu);
+	}
+	return (PyObject *)ppmu;
+}
+
+/** The python type for the PMU iterator. */
+static PyTypeObject pyrf_pmu_iterator__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name = "pmus.iterator",
+	.tp_doc = "Iterator for the pmus string sequence.",
+	.tp_basicsize = sizeof(struct pyrf_pmu_iterator),
+	.tp_itemsize = 0,
+	.tp_flags = Py_TPFLAGS_DEFAULT,
+	.tp_new = pyrf_pmu_iterator__new,
+	.tp_dealloc = (destructor) pyrf_pmu_iterator__dealloc,
+	.tp_iter = pyrf_pmu_iterator__iter,
+	.tp_iternext = pyrf_pmu_iterator__iternext,
+};
+
+static int pyrf_pmu_iterator__setup_types(void)
+{
+	return PyType_Ready(&pyrf_pmu_iterator__type);
+}
+
+static PyObject *pyrf__pmus(PyObject *self, PyObject *args)
+{
+	// Calling the class creates an instance of the iterator.
+	return PyObject_CallObject((PyObject *) &pyrf_pmu_iterator__type, /*args=*/NULL);
+}
+
 struct pyrf_counts_values {
 	PyObject_HEAD
 
@@ -1663,6 +1795,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "pmus",
+		.ml_meth  = (PyCFunction) pyrf__pmus,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Returns a sequence of pmus.")
+	},
 	{ .ml_name = NULL, }
 };
 
@@ -1690,6 +1828,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
 	    pyrf_cpu_map__setup_types() < 0 ||
+	    pyrf_pmu_iterator__setup_types() < 0 ||
+	    pyrf_pmu__setup_types() < 0 ||
 	    pyrf_counts_values__setup_types() < 0)
 		return module;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


