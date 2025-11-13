Return-Path: <linux-kernel+bounces-898406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588DC5537B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB866348901
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF311E8337;
	Thu, 13 Nov 2025 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQFPGg0z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQHGNEuJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE801DD0D4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996214; cv=none; b=aQqYNa9haSXwk+wJZdzAmFfH8nVEV9x7sJWIbz/pOMjdb/JA72/zV3tvTQKEeER372bWgkezBTnKN77YiTS0YY7obVHMu8QeAjDqfXEgJe1WpcRZVmXB07SZ8MMiy1jawcpKCzBIYowAbuqNsm7iwfxOFT8rLNrV0hQf12rZKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996214; c=relaxed/simple;
	bh=WTHbBFat8WgTLz0VXEBvhYA3zWQoc05BaGIUCPm9GuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGDq3qtG0Z9WXAH8PHcJfR9Oq37kcP7xP8wnu1hy9RHtJsTdjHcuu1fDX3O4EuAu1IJXqUyEHH3tO9GXG8Noa219c5H3bXbpZqc8cuWfK6mVsslATbKiNqw4NPTe+m81kUb2rZLYQK4MKr6WvSCE5J4z3DYl6epyraryWz9dqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQFPGg0z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQHGNEuJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762996211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
	b=DQFPGg0z5TWOoggKIWdRi/UMZEokdeKXSlRizLv/Qj8hReCStOkuXWf4DiRZxCge8tIpsM
	mkaEqqpnKXO9CwW9GsrLOujAf84xV+2Cl49QWtdujHBKvUOccXNUDFVLy2hqkvRAD+rzsp
	9FnroT1VuQBiiuH56/6KmBv1gZjABRg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Gq5hD199MQ24o9evJ3UiPw-1; Wed, 12 Nov 2025 20:10:08 -0500
X-MC-Unique: Gq5hD199MQ24o9evJ3UiPw-1
X-Mimecast-MFC-AGG-ID: Gq5hD199MQ24o9evJ3UiPw_1762996207
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343725e6243so1398949a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762996207; x=1763601007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
        b=QQHGNEuJs9LXmrbTdfPeU/WsLfc0MV2BmSRhsV43n5Sei61RwAySXwebzTT+dxBHIS
         DWw9s9hQMk6tDT+zRJyItvktnqkiuRlMTjNVA2FsP5VcpS/v7Y1IAV+GwH6mV+x0LeOU
         OFF5ibqdahqWVnY94cH4SLkz6lngfEphcRfHlDMAIU4dtYd4v9xSgn9EMijTEnwo/jOw
         S7zCSdq2f/7vacnaOIXSDoEeTU0UYJWNGVT+fJraWbmIUT/2RwKs37j+TTwoPRsov2ai
         lneivCM61zIv8ONy78vt6iFoSMjEWgcV8shQDGl3z7+HpIgzuzWCl0PZHzNgkq6O+bN3
         jYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996207; x=1763601007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
        b=ileXpZqbpiIn0QLzMFIeF3SKA5XKUl0i2U60IhVy9Zg6IHXba9UgYtesXyYwbunrQF
         XD8kh40HCAeiGt4d6hmBjrU6hzHYukuE3r3BBaeezXytdyMaSwVDIwrSqPCIfBchntSz
         TeokZGVFvypcbEbWilphRx/TeZ+csCfsNbJzJzTXbQNiue2CwwishUFbx16PiY6m/N/9
         FxiO311Rcwu63DTIQlG8WFIM2Lg6bSIF4brEBrVw4nlYWAxc26fw7r/rSeB4EKYUHqfu
         PLD4gLemMHFIUO8KmsSDWpxhZS4LZmGdE6WnsTny22kda6SMcYiy+1eUBIhwEhCDQP9T
         uO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx1X2WWXljTXZy3qbZa12N2Y3QgzVYjH3cOnKZVy49Fv5/tViBu4J6fZCXsAY0gtX5wLfgw3v6n0OUUi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFe6SSmoXYMjNB5oHO21Eol11c9msMdLf/YjVOt9cNMnbSXi7O
	2UWbcZoMR8RRyq6PqtFyhtLmjqqkSy64ijpD1n87znjFH1Fi+OtfdqctR8RM62360HWzAw0zNAR
	cMHsNzBbJjd/rul12/0NBn0FVGNNCIhd9SsCjA00snFN6GPkaU6CvxXXxULh1ZMtrlo83fVbSBi
	u6EWvjhgT/qkn4eYpt77I368sfdIA+c71pjUkPP8Th
X-Gm-Gg: ASbGnctA/u+ersOV9nepyp8+ALRbYQoL8Rmd31SFDc07RGdVZ2m/avIAQH5Wl6RmFwd
	CSO1JZlqyEATkMX1hWuG78CSC9WcAI9I6h9RPv32vlKw98MISZjk+tOosvvDI3+M3Fgi/818RM1
	yY9retNva3Uze+KrfagzeyZShklgmImxRCZvhZFYI4SenlySRrV4gdoQ==
X-Received: by 2002:a17:90b:5643:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-343eab2d6e8mr1479304a91.4.1762996206944;
        Wed, 12 Nov 2025 17:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ygtEnet5AzKgZkKuFsP7FTx9uhPWvwXy5utv/ipBEByquxKdhaAV2Jg/+1bKSY7kHGa3WYdxox8Xs01KAxg=
X-Received: by 2002:a17:90b:5643:b0:340:68ee:ae5e with SMTP id
 98e67ed59e1d1-343eab2d6e8mr1479275a91.4.1762996206546; Wed, 12 Nov 2025
 17:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com>
In-Reply-To: <20251113005529.2494066-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Nov 2025 09:09:55 +0800
X-Gm-Features: AWmQ_bkNFI0Uak0BVc9mmMYVp98tX8j2dw19j09dCC_kLqXSmWRrmqmpo5b_MMY
Message-ID: <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:14=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> ("vhost: new device IOTLB API").

It has been used even before this commit.

> In a heavy UDP transmit workload on a
> vhost-net backed tap device, these functions showed up as ~11.6% of
> samples in a flamegraph of the underlying vhost worker thread.
>
> Quoting Linus from [1]:
>     Anyway, every single __get_user() call I looked at looked like
>     historical garbage. [...] End result: I get the feeling that we
>     should just do a global search-and-replace of the __get_user/
>     __put_user users, replace them with plain get_user/put_user instead,
>     and then fix up any fallout (eg the coco code).
>
> Switch to plain get_user/put_user in vhost, which results in a slight
> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
>
> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> RX: taskset -c 2 iperf3 -s -p 5200 -D
> Before: 6.08 Gbits/sec
> After:  6.32 Gbits/sec

I wonder if we need to test on archs like ARM.

Thanks


