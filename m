Return-Path: <linux-kernel+bounces-737398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC17B0ABFF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5263B4827
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF722157B;
	Fri, 18 Jul 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="D3NQ51iJ"
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FA211460
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876726; cv=none; b=E/WghOWrxzpLIp3Cuy+3Gd7CWOduE+CijeVTFEqNKzpMoSV2ursYlFh0ONgnCZYu3WvV7gAYMIXxtK8VAXiXqIy14T8w2FeSFYCboGmK/9VV1JYimF3hQDbjwL5CPwQwHltRYLL9j7azZLlocHlkeaLsFQKDwpOx7Xkiw0h8g9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876726; c=relaxed/simple;
	bh=Ra3d4yk79GRZayeWZZmeTZHAUr1GECTgXY/nJ5YTfco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2lpBUqNk3Np+/dUIpopqdqiGCuU/NlWkid9OROJVQkIb6Rs80+Gvh4oxfJgWD8uqgMW8RM6eY7FEAaIJ42B++Wa7dAP3DQRgOrEAwsbw8ZV7/PUGx1TODpzWvShuu2Vt98cAxd6/zv2Oo5ajGLRiLkxhdQS7HS4k9vKKhNlm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=D3NQ51iJ; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752876719;
	bh=/07EaF41gnn4gEnfBX30qAY9V6Nyv0EgPAskka0SJFg=;
	h=From:Subject:Date:Message-ID;
	b=D3NQ51iJd+8Qa7176q1/U1DycfTMS+Sv8D5/D0Mva8A7zjUxOVdsxDNVaKhP1ekNi
	 cmmb0kWxXxFYVUczqQcIcFEw5skjbLJW1Yk3/21DWk1NWMrDwE7zOF1KzqURWVBrD4
	 FWRRR1M5xG3xUWYDZmbhmWdPeA7mYt86eZOJ5+JU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687AC6A400005A43; Fri, 19 Jul 2025 06:11:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6668606816158
X-SMAIL-UIID: BD9A24E909A44BBEA68488125BCB5FA3-20250719-061149-1
From: Hillf Danton <hdanton@sina.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Peterz <eperezma@redhat.com>,
	Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
Date: Sat, 19 Jul 2025 06:11:36 +0800
Message-ID: <20250718221137.2432-1-hdanton@sina.com>
In-Reply-To: <20250718132414.1572292-1-kniv@yandex-team.ru>
References: <20250718124657.2394-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 16:24:14 +0300 Nikolay Kuratov wrote:
> > reinit after wait, so the chance for missing wakeup still exists.
> 
> Can you please provide more details on this? Yes, it is reinit after wait,

The missing wakeup exists if complete_all() is used in combination with
reinit after wait, with nothing to do with vhost.

Your patch was checked simply because of reinit, which hints the chance for
mess in mind without exception.

Of course feel free to prove that missing wakeup disappears in vhost
even if reinit is deployed.

> but wait should not be concurrent. I checked multiple code pathes towards
> vhost_net_flush(), they're all protected by device mutex, except
> vhost_net_release(). In case of vhost_net_release() - it would be a
> problem itself if it was called in parallel with some ioctl on a device?
> 
> Also rationale for this is that put_and_wait() is waiting for zero
> refcount condition. Zero refcount means that after put_and_wait() calling
> thread is the only owner of an ubufs structure. If multiple threads got
> ubufs structure with zero refcount - how either thread can be sure that
> another one is not free'ing it?
> 
> 

