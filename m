Return-Path: <linux-kernel+bounces-750134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395BBB157C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA687A9D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E512B93;
	Wed, 30 Jul 2025 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoqpbWCv"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D083C38
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753845391; cv=none; b=tqBgq0Af4zOsIkWniy/tQYVsjvuB37bHmaXe2EfCxlNmUzaQHF7O5OhJUwvVjDja8SQeMi2sDDz0MUoqbYnECttHu25LvTLjqt7pIVdn0A3s86rc1ngzBmWECJ5mJExCKAVT2odKPsbRFy3y4fYy6/qtpREYaZXcgQf7vdyqsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753845391; c=relaxed/simple;
	bh=MN7GgaHIgDRbrqe3I07ng/28QqizBLcpdBKhjr4lKF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NQQLJDv97qGTzLS52SBUVTmUG+6my6RZpKyloFZ7LpNqB0KrKt17obT0AYQCCQc2LgijYuBKypE6rCiTWr+AxBvIZ/zCfpq9Hv1Tel/pNMOUJ88FblPoqMor7J9Bbx07pFnCGDhppZlmeg0w85Lp0eiLNE4kVfcObHuiiVc2TJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoqpbWCv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-749177ad09fso2800004b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 20:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753845390; x=1754450190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Asu+fopkVf6m2d9W4lxgsLTIcRr+Y4DqV5z97WhuY7o=;
        b=KoqpbWCvKRFAJjDEYIaDe20C9JlwctFbiPdwHt4fRzzd+HDmq4iutO0ptAXOvEu2g5
         ZFRgAjzKEsvNAGskvOExyTjuQZ0fC6+JRzxXseuvhhdt+qUG5/1SycfI7ZAEUNq9PYCT
         O92y3Z2qmdD2bnmyYkRRxMkmRQ0VnKY79Qo5jL3ZKDVVveWnmX0UTdFC/lylzm8CbqVo
         ifuyhIT3FhQ/QaZt7AxgEZ2vw42t6h6vKX4cnnKdj7EuiCNTHFWBPJ4x2UAoVoxmHbOt
         Xs3gCEveg505P3R40+IVbALUmjNXs/siwsmVqVM9KZJolPp01IfGlL9rikPVTkSH6V79
         wLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753845390; x=1754450190;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Asu+fopkVf6m2d9W4lxgsLTIcRr+Y4DqV5z97WhuY7o=;
        b=Qvb0xON6po22t8NhkgdTKnwoQytF0hyiKnIbSvA0paoZvKrwzf8Kjfs+76Oc9RCb9W
         phwDI+Ikort79BjZF3iLsCak6E7PAVdxbVYQBh/xGPk851sgcw+XA2DQVwaN5nutYoEo
         /KHLADNna6U+GQcHT0zuWMLjfQnf8POCUQcqSdXjlKh8AXbAF26jSJy6xLWr8yQ//B4d
         /UYFSLeJpkr8sDicROvxHecrsQ0mECIfP9dJjNNC0DP0PjzQQVp371u0uWEBMFV+iXgo
         KuR+uCi9ykmodW4flvb1A4OYFnMDyGG8dvDZS+083Qem8o4KEDTRlq7Iup1aLVGfjBQ9
         1fPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEdxvIHb3auXKNcH/PCSqshjNdH0tS3dvS+F8m6rBkC15EFpfwfjrHbZpBRQ+HOrU5kmxWg5NxCKfraAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPU0JarDIk5GLS/SICQ/9QkgqYAuN9QYGsr+U3mi3YasEGjIFM
	Z28g2aCN2maKkuB+j0itCGU3HVdcjKn5OadU549ry/w9VEgkeVx3PXA1/PJ973Z8jurZvzRXUbm
	ypXskhDJs0QD26w==
X-Google-Smtp-Source: AGHT+IEnrIySPqknb7uywjsaF+v7om3gojmPqMY1fEfNR9VibXM07aFjoVO7c22iFGu7Tfuvr+64FUDEsymNMQ==
X-Received: from pfbfb31.prod.google.com ([2002:a05:6a00:2d9f:b0:746:3185:144e])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b4c:b0:749:456:4082 with SMTP id d2e1a72fcca58-76ab082d0acmr2447294b3a.1.1753845389670;
 Tue, 29 Jul 2025 20:16:29 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:16:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730031624.1911689-1-davidgow@google.com>
Subject: [PATCH] kunit: tool: Accept --raw_output=full as an alias of 'all'
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

I can never remember whether --raw_output takes 'all' or 'full'. No
reason we can't support both.

For the record, 'all' is the recommended, documented option.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7f9ae55fd6d5..cd99c1956331 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -228,7 +228,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		fake_test.counts.passed = 1
 
 		output: Iterable[str] = input_data
-		if request.raw_output == 'all':
+		if request.raw_output == 'all' or request.raw_output == 'full':
 			pass
 		elif request.raw_output == 'kunit':
 			output = kunit_parser.extract_tap_lines(output)
@@ -425,7 +425,7 @@ def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
 			    'By default, filters to just KUnit output. Use '
 			    '--raw_output=all to show everything',
-			     type=str, nargs='?', const='all', default=None, choices=['all', 'kunit'])
+			     type=str, nargs='?', const='all', default=None, choices=['all', 'full', 'kunit'])
 	parser.add_argument('--json',
 			    nargs='?',
 			    help='Prints parsed test results as JSON to stdout or a file if '
-- 
2.50.1.552.g942d659e1b-goog


