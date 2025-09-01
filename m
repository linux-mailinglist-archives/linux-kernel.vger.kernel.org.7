Return-Path: <linux-kernel+bounces-794338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF8B3E02F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC82B17B47C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7430DEAB;
	Mon,  1 Sep 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="yvKfEiOe"
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779213D8A4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722706; cv=none; b=mvDAE7Vcw1XB64J9qIMxu+wske0zEmfBSBYsDFpiBMNdN2aA/0oq2H0KtgFV/RePfS1m1bwlTEtWYgRke91/dGnvO1bhtfnGqOrZ4YGgDUnnPScK1351cdbVnVO9VweIoQlLDuWFYVho9Emng4yogQOeTo/Vs6hVFKZlpQbtH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722706; c=relaxed/simple;
	bh=hWpH2tUFMzIxUSiCE6ERq9LKJUNR3bZ4105Qs5jaA0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVy7CdQqBFJiVtWPNqOQRxUTbxfGbEJcN6UElo7sv8aKHYuEk2VQp2r5x/aMwGCtn/1Gtp0jgarHfgcrVaTYu+GrkH0lOsCHTO4rSCfV4argPk5LMiPvx6QH6B+SMIt0XUE4IdC1gcWLYXNMljJ4un2DP1a93uSE5lYG5n80Pb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=yvKfEiOe; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756722699;
	bh=05AtvCc7k+4lVyxmaQERwndqLXMgTJAgkCeFIgMeQdA=;
	h=From:Subject:Date:Message-ID;
	b=yvKfEiOe4/RyMfKhb/6iQFX7vDSAPU+Mse0Ni+ane19i9kp9+L6EIWkEi3bmx7VKx
	 qySTttaHWvOk+VVhiTTGfdoSA8XoJBtWLD6+mOtcEEnL5326AACXb+bhFtqpXYx+mt
	 pLPuIKm45RdJXnVBs/olXIstABzHN82Ih1dLpbOQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68B575DC00003C10; Mon, 1 Sep 2025 18:30:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2021916816225
X-SMAIL-UIID: 4FFAF1C64D0E43CB996E117F18996D44-20250901-183054-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Mike Christie <michael.christie@oracle.com>,
	stefanha@redhat.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
Date: Mon,  1 Sep 2025 18:30:42 +0800
Message-ID: <20250901103043.6331-1-hdanton@sina.com>
In-Reply-To: <20240816141505-mutt-send-email-mst@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 14:17:30 -0400 "Michael S. Tsirkin" wrote:
> 
> Must be this patchset:
> 
> https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/
> 
> but I don't see anything obvious there to trigger it, and it's not
> reproducible yet...

Mike looks innocent as commit 3652117f8548 failed to survive the syzbot test [1]

[1] https://lore.kernel.org/lkml/68b55f67.050a0220.3db4df.01bf.GAE@google.com/

