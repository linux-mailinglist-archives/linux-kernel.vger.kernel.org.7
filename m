Return-Path: <linux-kernel+bounces-771203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F417DB2841E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299BF1891DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726230E858;
	Fri, 15 Aug 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg6n48tb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7F30E0E0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276103; cv=none; b=LDn/EUyo1LOrPsKpp0c8uEcOHRhDcyPTe309xPNYwzoif28X/qTuR2CzB00A6pfV6H9120nDTPHFubeAgj/2Or+JxGaRnh/vBMOxUIStXkhrQjbLSnTAP2jzAVP/LrSl3AlGwes6KGI8LEU+03OiMTsZW0b+tqu3iTYC5+nrbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276103; c=relaxed/simple;
	bh=fKl4r9zzM7OrQZZRoX6kZ8Oy3oR1LZjbgqRTl8r2RYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gL3HC9TVfqESVg4fcYTzfYruP0qSwHLncryV2kn6QHNpLecHNhavZ9w1z8woHNKo6sKPjD8jwjHIbfAS4rzIhP8haLOdCxPDrLThMsN2mWipclIW67t0/rno4eMXrFeRxURtmjMWfzhyyxEFvFMALmHorOFpueTLu1yq/a7Xm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yg6n48tb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755276100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Jsl2uvuC6o/d8hemNTeqxCWMeiPaCq+w+SKhYW+s3Gg=;
	b=Yg6n48tbBtV978D7IGgFdWWKz+rrbule3B0XceU+CIhtsvi0gfdPdQwzyj21GmMs9KETw9
	Dj7nrd3lFmsFlqSfHnlz27lP2yblbxdnurfgnEefmku35jiMlS5OcwU4NEUphjWIaR/+xO
	pqAOHvLx71Mi4d6hzlP/+Z+5hgqhOrs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-HFbmv8F4MKyBZcSQ4HPN8Q-1; Fri,
 15 Aug 2025 12:41:36 -0400
X-MC-Unique: HFbmv8F4MKyBZcSQ4HPN8Q-1
X-Mimecast-MFC-AGG-ID: HFbmv8F4MKyBZcSQ4HPN8Q_1755276093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBFEC1956079;
	Fri, 15 Aug 2025 16:41:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A740E30001B5;
	Fri, 15 Aug 2025 16:41:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 18:40:16 +0200 (CEST)
Date: Fri, 15 Aug 2025 18:40:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>,
	Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 0/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250815164009.GA11676@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello,

Changes since V2:

	1/2 - added the acks from David and Li (thank you)
	2/2 - new and trivial

Oleg.
---

 arch/x86/include/asm/div64.h | 13 ++++++++-----
 block/blk-throttle.c         |  6 ------
 2 files changed, 8 insertions(+), 11 deletions(-)


