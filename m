Return-Path: <linux-kernel+bounces-864724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F261BFB688
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEECD34F9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836C320CAF;
	Wed, 22 Oct 2025 10:29:52 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358C309F06
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128992; cv=none; b=gqqMNe/iO2vDNobl8i6kJOeKPZfLcn2oRGr7xHSwaLeD5CprEFg+GzAoeUWhR4Bxmmfd9VjMmG2AjZD1vJoZrOfUILkLnkluSXN9Le68Z+t1kMPve+q36rcGelvAS9QhfcxQTwl+O9IX09FsbxeCOBMXELezUCKIkx3K3k/maJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128992; c=relaxed/simple;
	bh=kdSRc2n+zbf34pa4XAwNzC2gPjF4Pjl/j6NHxK3mEDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=auYDMtOBopomyPfRrdywoCmjbjEVOvLibBOJ3Vszz6oedKpLia0Fc63X1lukWxGt7M+lxWNgLMAZigckIhADVdFXYtjoHkV0A6lCd13gHGkD2E2ZzkBfvbU3gOPqW/xMsE0lZwvSgV8mwyb7fSopUGKah7db0OanOScz/OowaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-925332ba890so1806379739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128989; x=1761733789;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdSRc2n+zbf34pa4XAwNzC2gPjF4Pjl/j6NHxK3mEDw=;
        b=hSTKpnlFEWoFfOLe4ySXM6hIiS+2kNQBee5HC6i1YCLlmScXO0EEuPQQkXEYo6hRzV
         XMr7LvPRce2mU8Up6UDSiyrZ212e69QkZt9yidZhBWHWl1PWTS/4PvPBuWk8tV7Sgrhb
         cxl+CWt4J/PLfGFAjomd+s2La1U9SX0yn7ql37zfP3T+Wf0UTyoRWWGPMeWKnNLaBD8m
         uy5AGdk7zOmh0UYzrcCzvadOioFBJrOA/fjXOB+72FMUe3zDEsJzGwazZsBebxhRxjdZ
         9UmcaPihbIMLtTcbS1N7i8QUGRMOPy7ByxBPUsqVIoE7keFPAJvFdOv0dDHC5fwUL/Gu
         eN5w==
X-Gm-Message-State: AOJu0Yxs7Bfk1q9mvCu7tPKyMR1Sclggg8u/8aNPfyX4HMDIgkWwnApF
	usCBBDvkky/lFBzKYfl2ujYFi4a71LIphWvq8dytNE/mytfyzoUz0LS5ZCGqae7xrieO9pXtkvT
	IzoCJqanwgvuhXNuXiz9t3EreE3ESGVNF54k7MPgs3TsHGT0x2gBSNhbhvXI=
X-Google-Smtp-Source: AGHT+IFZIlMteL7J+X2zALmsOA4H+KYAKFWoI3yWYSZV7qGnpL1utPLWmrEK5O0sz7qWo2YZUOJ8AS0Cx67MHDPnNtsX4NoRiOTj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2296:b0:936:dfca:f79 with SMTP id
 ca18e2360f4ac-93e76280d62mr2819763439f.5.1761128989278; Wed, 22 Oct 2025
 03:29:49 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:29:49 -0700
In-Reply-To: <68713fad.a00a0220.26a83e.0057.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8b21d.a70a0220.3bf6c6.0013.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 552c50713f273b494ac6c77052032a49bc9255e2
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2

