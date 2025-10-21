Return-Path: <linux-kernel+bounces-863727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA58BF8EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA20406E82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27D028C871;
	Tue, 21 Oct 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="T5pb4ClE"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85528CF5F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082204; cv=none; b=VexPJ0uQvG/CKngCBxCcEPSt374CYRDdjRKgZV54+gvXX8jkwZIyXKxitgYsWlZ2JqFbXCWOz28ifzZg/ZEiQKXz3L5iLCfkCWgCmqnSkPcJc8N/xQIiNGROPzVVX8JkuavC3zcPlskGMEfkrplfL7KXoD0Do+4aKgIWlCJ2sPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082204; c=relaxed/simple;
	bh=dwqMl/vbpfqiF6alkHk5Yx63NAGPmT9VgqTEeDD6a4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upmePwN0/fiNT+PQA58nSy+7dJJ+eaRVwXaZhJca8ExhuGzZdu745uTaDcB/Xmrr6fiAIR63APId0Ov2dFYe6dY4551hy/fsg1wX2sGuVqPI57z6oSm/GFbB7K1SqkmO3EpEWb3GsuozmJWrs05YKhjAOifK28U7YEBn/pEHr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=T5pb4ClE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5062208a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761082202; x=1761687002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpZNM3XgwJ16I+fZmWCMaO7DLj0Pq/ew1phxLV7Le84=;
        b=T5pb4ClEb04hNTu5kowJOKmmnkqS42iBHe9aJGyrRtUI4gFgVq9LUOAC6sT6sUMPUI
         UMGfPJ6fL4Uhu1Vm1e1QlvbB8O3G4xAJchX0U9rGOiJRSirn72OOgAcAtpmH+IUk156E
         GlRzyOtpHJgUoChL7ldReZORVpjHRJdl03Sg6ajh/DEk9ochw9YpncIInAlfUrCnE8YG
         Z+k9BSCnHKZO1dKWNHaXCY8bSxq3ceiDGz2gCYRKDL3HStK6r69mN6MVR0nC91ne3Qo4
         UUmz9IAQHGR7Gz/REAjmz2bBBrwhvU7Rez/qOX/EhQ4v68tH69u3sf4neUJQNmppgwRc
         juUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761082202; x=1761687002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpZNM3XgwJ16I+fZmWCMaO7DLj0Pq/ew1phxLV7Le84=;
        b=Fii7GAXVj11+XRE2AgWRMMi+0ufmc35i8A6u++QhJMEeCOuzpyzjp5yDsaHLNnQRvK
         iYt2n4DRcGWOdnWZKlpepLt0qUSKBa2Q74GVyqmpmWeTPNQdnuoCCKBLV7XKAHTPyUUx
         B01juMdyvuv1vFb35U+WOiwv0NcCVtpwdm+KWtKz4KqVrl87dsPq7nvHbqo5FpdMb2Ys
         u5/6V+iALpqGUkvkGzdvEGs38Ztc+dCsoqhOzxPK5XOM1cqM7kJGCueEhzWpa0A0qmXA
         E8vOs3MqkN/8xMs7yywRdwUA2UASgu3/gjDAKzGGdNXXs9kTQjhUo0PgozWFDD1QRc1e
         FHaA==
X-Forwarded-Encrypted: i=1; AJvYcCUz6cR9n3YRLbuamPmInzmBL84YlqweXEHqgnNo0jGTdMEV57qYh/7g7mq07NPltUxC3a3IHtxESkBT3VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Zj/QmktbIlF86485bVBqtR4h1N9cwr1R8uFx+VtUKiOWxzKT
	+eZ9JtUZAu0JC9smk2yBKqlDxGxVIALAS9QXDbPUEBi91aiZ/pDpPNpYm7gsnUzq1Ac=
X-Gm-Gg: ASbGncvU72L157znbFr4XNTjtnvGxQSYu32EXiDhSIfWQ9ttaD37mlG9hnC9cFF7gfc
	2AFYDt889O1RVEnSA74YEdEC5jkeWlCsBofE4bAZ9+kGHKTwd58P8HZp4ecjNJMjVkmr7amx+Ko
	CUQJGzjO+/dYC+tiy4kNgb9H4xzF01bDV+PdQCy5ZXKNc9QUmO+RGF9XevNYu8HK01Ngh9JZm8D
	OC1xoMOEXt0/YNZCEyLZd9uL/P5FXNeur+WRoW1ZCSjItPFsfnOyqB1aD70tGRe8eJ0VSVcCvyL
	qYchNWUOSszQWAPyy4dC2HZwmf7K/JiePvOhRq+DoxwrYfyWhgXfBcB/1CFF1XS3K+WKrpv3i/H
	U8DTz0P/m61X4FuxvF6Ny1FLMp+L8kqqIYx2uazp6XmjyeOzoWuCmQ6twr32DlMCnxDDyIiqQgP
	UqJFCno3SmuDl4
X-Google-Smtp-Source: AGHT+IFQPQVLF62iSQjgKED/7MJICfhrVLj1XS5eTii3vZpdYHBP+K2MnZ4pOMVYwQSUDUzd3dAjAg==
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id d9443c01a7336-290c99a9669mr215805815ad.0.1761082202003;
        Tue, 21 Oct 2025 14:30:02 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5850sm118793665ad.66.2025.10.21.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:30:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:29:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPf7Vz5K6P7frdlf@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
 <aPf5DZVYrc2YAXXT@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPf5DZVYrc2YAXXT@mozart.vkv.me>

On Tuesday 10/21 at 14:20 -0700, Calvin Owens wrote:
> On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> > Hello,
> > 
> > while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> > Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> > 
> > While the firmware download always completed without errors, subsequent HCI
> > communication would fail most of the time with:
> > 
> >     Frame reassembly failed (-84)
> > 
> > After some debug, I found the culprit to be this patch that was integrated as
> > part of the current (v6.18) cycle:
> > 
> >     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> > 
> > The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> > used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> > that the private drvdata for the input struct hci_dev is a pointer to a
> > struct hci_uart, but that's not the case for the btnxpuart driver. In this
> > case, the information about padding and alignment are pretty random and
> > depend on the content of the data that was incorrectly casted as a
> > struct hci_uart.
> > 
> > The bug should impact also the other platforms that were touched by the
> > same patch. 
> 
> Hi Francesco,
> 
> Thanks for investigating, this makes sense to me.
> 
> Funny enough, I specifically tested this on btnxpuart and saw no
> problems. I suppose some kconfig difference or some other innocuous
> patch moved structure fields around such that it triggered for you?
> Not that it really matters...
> 
> > For the time being, I'd then propose to revert the commit.
> 
> Adding back all the duplicate code is not the right way forward, IMHO.
> There must be some way to "mask" the problematic behavior for the
> drivers which stash the different structure in drvdata, right?

Actually, the right approach is probably to tweak these drivers to do
what the Intel driver does:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bluetooth/hci_intel.c#n869

    static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
    {
            struct hci_uart *hu = hci_get_drvdata(hdev);
            struct intel_data *intel = hu->priv;

I'll spin that up unless I hear better from anyone else :)

> Any thoughts from anybody else? I should have time to spin something up
> tomorrow, if nobody beats me to it.
> 
> Thanks,
> Calvin
> 
> > Thank you
> > 
> > Regards,
> > Francesco Valla
> > 
> > [1] https://lore.kernel.org/linux-bluetooth/be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org/
> > 
> > 
> > 
> >  
> > 
> > 
> > 

