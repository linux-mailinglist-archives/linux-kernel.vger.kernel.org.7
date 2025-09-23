Return-Path: <linux-kernel+bounces-828545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFCB94D96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780097B5AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C723168EA;
	Tue, 23 Sep 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb+jRBoa"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99081316194
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613644; cv=none; b=DSMZo57tUlCRdaMEUp5Ru8UVCtzOAo1nUtFDDdLuzYuWn2MKI7j5iyzfzWPVuPDb8sd7Ue2AEwGfrWV9lvlJlNmy+tHe/I/lR9FHmxqUh6nBmcH9p57jj5ZVrkWSyrhYHR2J30ecOJP8kXqf8btlZO9xN/jWrnHs26OtrgqviCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613644; c=relaxed/simple;
	bh=m6w75x5KmuboRbte2t8Bef+Y5vLZQaZtpC0JTZQjfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHue9zICSbl/cSW9o3Y0vmRIYGx9W6u3WTEaK6JOJzpMQGmghw3Unt6QHEPzRmM4MVBlujCkQbyd1k4Q3k22la9A9z0bEAIkhz1CJICQR0XcndWx8KutWGyDgtzFw3DZ5xAebduCK3PdyyeJiOJGt4NQMVp9VgqrK8bles3O69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb+jRBoa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso1744236e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758613641; x=1759218441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3zTrXIgrjNde7MVV+dQe94AXCJb9BQSJNtQ02xJwZs=;
        b=Hb+jRBoaW25Oj5LVwuGp7pHGOFDrDFFhIeie7Dfkq7+H92LLpf9dwG1qxKUu1KIpXK
         a/+ETLzxr+qq6Vfu9r4bMk8iF4z14DgqEzefgubl9MbHat1K6GPmHCzsRMZQsn5cli/c
         y+37BqQKvT056OX1pmV4nkBy1M0tOrXJHHLYTX5/30rCKPjKYURVGchkSCOFrYlF4kYg
         K9GkjJZS9AVEAOPnwxvU+Ng0lgrJH6AQ0sDuinpD6dC9iZvf9aOw6mklkaMgK1VN7H+v
         dySneeWOdEqBp330cNJV29C5OkWDgrMoYCVCQzyX13KEXMEYYJrzzMLTweOkWEVbfzqL
         fAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613641; x=1759218441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3zTrXIgrjNde7MVV+dQe94AXCJb9BQSJNtQ02xJwZs=;
        b=ggRTxmEU28Wrf6POdPGMqYGajZiNEZ+UGRyJ7+BFhzzmKJarzrReK+BqCUB+Zj9/zb
         2GYbDQ2C4kbwo6THvo5ldnsrm7BO80KqL2cMI6RqOOyM/85p3spvvCZcHcS8XnbN/Jq4
         wvxpsBwcXAxqMQUs6oBNBB5PZlP8Apb5fuZYLNZhSEwfmTu1Pz2dNwUNyxpYorPt8+7o
         ITLJAgmFWx6csFuahJ3Ny9byz6fWCPsj2oQkCjTUxf5xm58NNghr810go205AUOnD61Z
         F+b38pIxBKi+pcQEmWm2YxrDJ0sigzebWA3cb3CGGXDt/4xt+go2kr4jqVp249SC012T
         0jQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+kBHXhZVKWnut+gPKdra3ud1yDQqSSumbZnYADCRGpqksfXu8WaaASGl82jRpQ7dMaYvSerR0VQ2BQ68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZm+vqbHEqt2H+nD9qTFcwiP61aqdDt+XeAUurh0E0HBQY23GS
	msRN6tjRQU5mzz7Xi7lzXIjzojZTjd9bSVGDxmDoDaBtb27hjsuXD8bQ
X-Gm-Gg: ASbGncvTzVdp+NGmafW9UcpwYE6KZy9yv2QgeLEoaV57AHqbIkx+CfT5eGitiChjA+n
	vB3M1XrDwRyra+coI76i1ZU6sDMJeeFimPdRJvWohjCzD4J3+ko0o2maZIY6W7F81wBAb15nDFw
	guYiuUoKeSSCtbkIx52akbwLJwrZGl4XdVC0HYRvUK0Xd+S0zSOW9UlI+B/Nv9ROkvOUjVoep/V
	Y/fkEqbHT01vOMPjsQXpT9dCw2OOospE68iK9lcAMCssFIH6fAB8Mr/Hy8En4R7IQ6VU7TCbaGS
	aFU+jmOtMPALZn2+rsm0pp7e0CYnBWfpj+xTX8xbirAY6Ydbu566kizpR4qB0mblGFepDJ1eHu/
	6E0Mr0uTQsInDw6TUDKrVS34m1fa8HNzBXDM=
X-Google-Smtp-Source: AGHT+IHdpC5HbX3ix1zT26Flp+EGyUUBeKiByHFSuNEWqr8rJkXfKIJvyKcJk6flJER7ibjGFmTI7Q==
X-Received: by 2002:a05:6512:4207:b0:57e:1e1b:dde5 with SMTP id 2adb3069b0e04-58071403f46mr357677e87.25.1758613640434;
        Tue, 23 Sep 2025 00:47:20 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57fcb89170asm791542e87.63.2025.09.23.00.47.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Sep 2025 00:47:20 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:47:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, david.hunter.linux@gmail.com,
 edumazet@google.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com,
 skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250923094711.200b96f1.michal.pecio@gmail.com>
In-Reply-To: <20250922180742.6ef6e2d5@kernel.org>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250922180742.6ef6e2d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 18:07:42 -0700, Jakub Kicinski wrote:
> On Sat, 20 Sep 2025 23:48:52 +0530 I Viswanath wrote:
> > rtl8150_set_multicast is rtl8150's implementation of ndo_set_rx_mode and
> > should not be calling netif_stop_queue and notif_start_queue as these handle 
> > TX queue synchronization.
> > 
> > The net core function dev_set_rx_mode handles the synchronization
> > for rtl8150_set_multicast making it safe to remove these locks.  
> 
> Last time someone tried to add device ID to this driver was 20 years
> ago. Please post a patch to delete this driver completely. If someone
> speaks up we'll revert the removal and ask them to test the fix.

These were quite common, I still have one.

What sort of testing do you need?

