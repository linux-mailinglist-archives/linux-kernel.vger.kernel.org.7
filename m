Return-Path: <linux-kernel+bounces-780754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45EB308FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B89607C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE32D249E;
	Thu, 21 Aug 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3dvl0s2"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC42C029B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814722; cv=none; b=deHXjXjP7kapoF78671o7SFl3jw8O8k1mL/1p+v0rjVHS//WmpbPCRz3defRw+Iz/aagz6sVRvr271VOPui11cZnn4UE+TVEpIKvDZ24xzLLohC/Pn/dzqjAuXssMK3Vne1zxIx0E6UE1KcFBK/s/9Ta/jKFbLvKZDOUJ2uDvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814722; c=relaxed/simple;
	bh=K0symyrZuyZvqS1XBD24qplV3mvlV//oYKSTemn9QkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rIo3AN/OPVhjGpnOt3PDJKgKx481SdqK8lBRWlvNX77nAqlzuJDPJ8RHlLCFWa9AWPZY5i0bPnfTDCwmxgY9H1Q1F+3O5nl3CJKX0Nz+5/VQij8NvYLRIcv+BPyGVUiK6Jg8dU8WHqgl4qJe/pyJ03e03XE1Ti2+GKlrOG2Bh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3dvl0s2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e60221fso3112848b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814720; x=1756419520; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cFBRMtm2qDJHWakDl01mNCIUuG7fMg/wQlZbnAFILFc=;
        b=O3dvl0s2TsCFOGpgvcY1+V4HO1GocxiboYbPlB5QFHOkHFamD45dIytRbAk858O++4
         34a+P7VNbPRLm3zB7K9bL7oH8agNzbBzgcYAr4p+NST0bE4WyULomqLa8FDqirbG8/Jj
         aSNFjSmURtaoBBwbaleWu/mNsG9PQUwLe/Kn0HD9LRB3F1GZ4n9BjD5Ue0/8ibsFQVGl
         q9FbBDbXyOKSjora1TpVpx5/A+q0Bd5L2dy9JwiE1ZlZGhJCN8qCx9AK5ipUnnpK6zYd
         uIvpIHzQE+1MRlfxgJ6RcbkguV+C87+O5ftCDzN/8iV+WnPNfbtnEYYchS1JPzcdcx5C
         a4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814720; x=1756419520;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFBRMtm2qDJHWakDl01mNCIUuG7fMg/wQlZbnAFILFc=;
        b=G78wDHMzPyWDqxx47xiJRQlhdDEdG7TKLn5XJxnPXzXwXDshHgjyBZX6oXExcWKgax
         1o8eqNSRmfFRa2pU3YpncEgwwd0xsaEoBaX+qMLZWNUIxpC0xU96gBL2tRB0diG+nPyV
         QpKCtkMjyg9i+JPX0adiSdq+wu8RXMZ4IlaYbDFrDcjfpoRV2xZfLD60U5kFgUf2gTVd
         BjUQ/LyX0GGMVDh35A5hEMLesVSEZs4q8onxYvQ2JWmZts9TdlL3A1+fEvVt6miR90vG
         YXSmg7D4Ln2tp/f6R6edt86yO8Nd5ksdEZ+zqB5fEgEgNSI58Elq0dRSm0L6kVr+NfGC
         OXwA==
X-Forwarded-Encrypted: i=1; AJvYcCWccTC4fAek5SrM95s2S82cZlgHJ7ZaTmv5KVPC1j7SV6yKu7roeMjYc+5Kk31UClCGboVoyRBY7yUvMC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPsI2HTDpWzZBB0ScB3fbDlH/QuJ2DYwqBYO/zSLThwlfnWQ1
	wLPbTiWPCkruriODIIUHn6eOKBdf7eWnc1Gtjr0Sc5e8wqxeDR+smpzjQM3yjNwhtOJNl6wGzIi
	hjxav4pXk5w==
X-Google-Smtp-Source: AGHT+IEYCOqIVvEgBg5sE0uG0GD/Uwi7bsNao2K16RSgQpglbB8njv7CwRYmCbYulD290cjdmEXQUl3QhEqK
X-Received: from pfbbu4.prod.google.com ([2002:a05:6a00:4104:b0:76e:7b1b:137d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca8:b0:76b:dedb:3048
 with SMTP id d2e1a72fcca58-7702fa0a9e3mr1182787b3a.14.1755814720446; Thu, 21
 Aug 2025 15:18:40 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-1-irogers@google.com>
Subject: [PATCH v1 0/4] Test/uniquification related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Failures discovered running as non-root and with v6.17-rc1 changes.

Ian Rogers (4):
  perf test shell lbr: Avoid failures with perf event paranoia
  perf test: Don't leak workload gopipe in PERF_RECORD_*
  perf evsel: Fix uniquification when PMU given without suffix
  perf test: Avoid uncore_imc/clockticks in uniquification test

 tools/perf/tests/perf-record.c                |   4 +
 tools/perf/tests/shell/record_lbr.sh          |  26 ++++-
 .../tests/shell/stat+event_uniquifying.sh     | 105 ++++++++----------
 tools/perf/util/evsel.c                       |  28 +++--
 4 files changed, 86 insertions(+), 77 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


