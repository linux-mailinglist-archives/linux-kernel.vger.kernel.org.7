Return-Path: <linux-kernel+bounces-834832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193ABA59C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F205E3A8B44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E8259CA7;
	Sat, 27 Sep 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2FRKvFn"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E7227EAA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953540; cv=none; b=DnWba4pVBpvk40Y/t+TB/rKVuLSYnpuZcwBKLuF4RAHM3jpnxLQE/uIB2olbWt37QRY2l9zpMO9QzhG6stnbfwP5CsLsMH5uXy0Utz9Ek6Tp+b56v3D5VsS6dI9ylJY0wQFB5sJTGMPPSQGryss6ah2ur8iG7D6m0H2x1KXXY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953540; c=relaxed/simple;
	bh=S3l06A1JhTVKNOxW4NkqhS6UTCCL23vhN0vivrl4ftk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Scp+dmyLQFwD/ikQgFwwmAVqLsfixrfMKLdkbZzUDq0mTELUMbLWDqU9nWrrv/8dqjJPpF6mmEb0GhZ2Ab6jWEy+HgkmVBPHXYYhALgypLJrrIARYm49VEoMmu7QQgNnkoxY4sucxKnGocylH1IY0DnVrFo4saJRQopndxyqJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2FRKvFn; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77e6495c999so3003458b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953537; x=1759558337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0/bqr20eD9aHdr5W+3qtM0zghikkgsYOauT28Yj4ME=;
        b=h2FRKvFnM2QvlLTKNm93QTjvFGMEXmT851L9FMbzHxRTRxyQTb+H+K2t3kwhYEdkyr
         2/BC8GqRQ84QBmXvkqPeRRCHZ6d/OHTGwMEvg9bdSddhRFxr5tzLobKs5B1JYmxoDth3
         kBRyL7pJ21u+GDpcyRAvf87BRmCTkZfWkh0c4NB8HY3Hc27tIPIe9+dBkQMycXzdrNQF
         vRHWUaj8UhjTw/5nzc7iukSeoS7/yqDUy44Fr6QwOPNG66AHUO1n0/FuWhCkygjt/ELU
         Qaw6Jw3+HztrZcYt0GJfAKc8tLimS1Ubb13tM6xxlkBxv8jyjBxK1qcI9DzlvoIaXbj6
         QkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953537; x=1759558337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0/bqr20eD9aHdr5W+3qtM0zghikkgsYOauT28Yj4ME=;
        b=dUtiR1vG93un/iJSEZrxWgQgAFneBUTTNCjnoVpmhIx4WKNZ1s3BD4DVrTdxywYCaD
         LiAPyzPeGE/1v2H25GQbS0/oVnR8JS/3AghuONEIiduXcwcKvy24gOSCnHiSx7DuJHnb
         7zkvuGqt70THqrRO80nhwH88qylJgDdkpnPR1WRtbWxBSAKKHDdAhhk5xpo5j0FgjfpC
         xpaAwr2mpABRCkG0wTMfUsKqKp0ievFrqJlE5sAKJbX2449nVg0gmtazrarZvVtWW6cd
         SO9NgqsS9stYN2w0UbWzmB2O7DC13Pxx8EjeQYCiFcu5SikrkRR9PcGQnlj9FIwyoexA
         ZtCw==
X-Forwarded-Encrypted: i=1; AJvYcCV5JyBqbw+6h/l5AU0hpqU4JqOH6eUDkNn4T+CO/W9xfSjXKXwOS1lwj50+Qv2lx3JcMRqXgEipLdxxsXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStZN56Hf9Y2Iv26MU7MeyHKokRvWXTYJY4TibA6i63BzCSBIp
	2WuhLc0fHYTCUCA2gPwEZlDUba9dNA/hBOknhdUytwbyMziYX+pydDgn
X-Gm-Gg: ASbGncudzV26LmSXdmK4OwkIyjEhtPMxVtoR4fJGR4qX/lLv3dvbMuMMU7lRj8XonIi
	4te2xY2Tx2ut6kMKhF5BoPMWjcjFo0ziJrIsJSxxcSNDsLbLBcH/pWinqazvvnKT2OOFdr5f8Vm
	SyQo8dTh8/ifpr0MGMtn3nG5cyxSDC3lakdDfyvJFY8/BqUqJSc7IOBsDDWWwNDLGSW+0R9VW/3
	1BDG2TzNuegJYn6EaauivoUE5RV79nAruwZuaxSA7mO0znnygcg0sHFvBIcy/z4WqL82FsE12ER
	dvsJ9ECKeHOITNNICPoJHbvcdMMKN2IOiBxhmK6CNJW5bA273ByNh5QMWZEE4uzR6+U8X0C/4xw
	Zkw/2+v2qxBycnlrDIqbacwtqly482A==
X-Google-Smtp-Source: AGHT+IFs9pSrNNpTib391I/iqQ3SZvzLn53SsMSuMurvpANlMS9GOQCN/CHJaj4SpF+KTUi5oYCZTw==
X-Received: by 2002:a05:6a00:3e0b:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-780fcef7c3emr9599121b3a.30.1758953537252;
        Fri, 26 Sep 2025 23:12:17 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:16 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 0/3] bpf: report probe fault to BPF stderr
Date: Sat, 27 Sep 2025 14:12:07 +0800
Message-ID: <20250927061210.194502-1-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can do the memory read with bpf_core_cast, which is faster
than bpf_probe_read_kernel. But the memory probe read is not aware of the
read failure, and the user can't get such failure information.

I wanted to introduce a fault_callback to the BPF program, which can be
called when the memory read fails. Then I saw the BPF stream interface,
and it's already used in the error reporting. So I implement the probe
fault base on the BPF stream.

This series adds a new function bpf_prog_report_probe_violation to report
probe fault to BPF stderr. It is used to report probe read fault and probe
write fault.

The shortcoming of this way is that we can't report the fault event if the
memory address is not a kernel address. I remember that we will check if
the address is a kernel address in the JIT compiler, and it will not
trigger the fault event if the address is not a kernel address. If we
implement the fault callback, we call the callback during the address
checking by JIT.

Menglong Dong (3):
  bpf: report probe fault to BPF stderr
  x86,bpf: use bpf_prog_report_probe_violation for x86
  selftests/bpf: add testcase for probe read fault

 arch/x86/net/bpf_jit_comp.c                   |  2 ++
 include/linux/bpf.h                           |  1 +
 kernel/trace/bpf_trace.c                      | 18 +++++++++++++++
 .../testing/selftests/bpf/prog_tests/stream.c | 22 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 21 ++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.51.0


