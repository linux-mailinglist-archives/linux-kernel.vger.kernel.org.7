Return-Path: <linux-kernel+bounces-771369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30FB2862A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6597B3773
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564CD22FF37;
	Fri, 15 Aug 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Sp5WLOrl"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44E225402
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285046; cv=none; b=ME8Hhq17gC5Y0orZoqx76uo4QjJ1rmBjRc794LJ/b5giXi8n4KSrwmT9YCWuetkNtwG9LXpRsJ9shnqCXQ7bPfS+5CrVS3JQH/ueyrGFrSiMQJqSJbkUXredTaGRsfwT37ad1T2o8Bf1Dp+JZ83VwjiM7P6wBlGsULsqdfcGfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285046; c=relaxed/simple;
	bh=jHfpzks1u84wKKcNabheHrxwFqcW+2R/7ybUl6Wn9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WygTMsL0cBEpiRZAAQ3b7vCeObMCI6q1y1rd3qSeq55qwJzzve1GTC5yMz27oHMOIBFN3D5SDD+OI9Jvl8VmCtqBUiM3qSf+kKrAYpz8gd9ZmscRpVPuS5mT1h7A+K9ibwcZMXoVim4TJfptNptl0DTCXAw3fiYYvpt4NeBZgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Sp5WLOrl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso2804305b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755285044; x=1755889844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnpReH2bgtGhv0n0ypVNfzr+6AJxdugzJ+usWN2oIgc=;
        b=Sp5WLOrl6bAEtfld29E6MobJSoeZkV6lPpK0LNFhUyw8PB42wtDdKqQUny8BKHQRiT
         Eiodth3zqrnzzUUwQC7delLEQ+TZT+WXJO72xlM6g0cEf4FPySyYPXmef/u00TrS0YkD
         MIdhFQ3BkDEoGcQPaKwFQ8I9tZocPDvrP9/n3lAhpToVElPYO75z+Wo1IT2fN48TUF/m
         q4ZeTrbnnAaLHnNvGarDffI34HMgVy9WpUEMZKHt/ZqxwaL9T/td93GzYd7JtkoJCFdt
         ME4B9rRv/t6a9nXg7lrXlM6qP3Ws6tsMxP9HSGg6uuPmVsI3olU05FVs49eWMIah7b6S
         b9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285044; x=1755889844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnpReH2bgtGhv0n0ypVNfzr+6AJxdugzJ+usWN2oIgc=;
        b=NyZ9D8iJ1EUweOL2RoAk5JBWuzozHF61pBHXZC0USbRJjDgIKuXxxE1E0jDtEi3aAM
         4LVA8LC21DZMb1whcXSPRQp3KzI88PNIJNxdO6hvgfoOfoZemhkq/4DU0k06GucA4ilg
         7CaJ9EwINiGYyjIHKiB8U5Vak3ftYRBQKJQO5n+wodY2iGGBNx379hwbXp61fQsxkz42
         2IFXyA4Ib2Q7IorDhlhtZ1F6wqHgRrDf+wsXPl7OihCCB3wcstkKEMqGBq8l96aNU07i
         JwmjeEMtE5vNVUjEYw+duw3rQfvLEcQhOgdqmhjy1lVeliba/MBdJ+PY61QEEzdPp4/U
         cObw==
X-Forwarded-Encrypted: i=1; AJvYcCVU32QFyRqVgyulFUMYds38RHbCX3GNjjnxcuvmTl4cy6GKUmUTmGoODJiTRgi1+EHFGsIIg+y98Lp8UDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwzrXV2EibxTd2PuqnW5q3RGPu+7iCxybp51s81iiE6Lq0WVR
	F2keNuth2rNLRAPsCmQIQ9O6nTqXZkpFU8PXRdk7kL8C30Hiz0QJcm7PGz46qTvzPPc=
X-Gm-Gg: ASbGncvNcggCe7w+A++KX7L5JVg1eLrgDXyiTv06eoIO1AplSM+NJFRN+pNJuHuKHHx
	g1kR9KZA1mWhYrIMbeAD2GfUIOPMvTSGtmF5n8xSHdrHXH3l1dBuvQzM7iTQ/HEG4RCXcDybNvM
	vMFLIKBkteAnUSkkZjcJ10XjFo0lPY+ntgAQdX3zsan5XQqIAZNrclcJ3ikP5a21DGdRaHcW2vQ
	nyjbnt/7/tAGPmdZj07Nkp7Nsrrmk3eMY5AKfLnUeKtifEVnY3J+Jm7QPG1SMXgZcDj7744crWl
	7N+Ynlhd4dSBVsqRzWvs7/NKJsnvQxq1Tlr44pFNgKn12IN9Aokk0AIRyt3NGojtJL+DPBmvYh9
	bBrTwj66avHRyRACyd+DFuhkq
X-Google-Smtp-Source: AGHT+IFeEdvUUXaiSvEnfT3o23aDPpP0MhB1dcC2p0t/Kh9muZfwjjarBDT+bAjztOsxlTtIorfsDQ==
X-Received: by 2002:a17:903:11c5:b0:242:fb32:a51b with SMTP id d9443c01a7336-2446d79cc95mr46828335ad.19.1755285044305;
        Fri, 15 Aug 2025 12:10:44 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d051sm19752345ad.11.2025.08.15.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:10:43 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:10:41 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mike Galbraith <efault@gmx.de>, paulmck@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <aJ-GMfXarWgEoYTH@mozart.vkv.me>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>

On Friday 08/15 at 10:29 -0700, Breno Leitao wrote:
> On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
> > On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> > > On 8/15/25 01:23, Jakub Kicinski wrote:
> > 
> > I suspect disabling netconsole over WiFi may be the most sensible way out.
> 
> I believe we might be facing a similar issue with virtio-net.
> Specifically, any network adapter where TX is not safe to use in IRQ
> context encounters this problem.
> 
> If we want to keep netconsole enabled on all TX paths, a possible
> solution is to defer the transmission work when netconsole is called
> inside an IRQ.
> 
> The idea is that netconsole first checks if it is running in an IRQ
> context using in_irq(). If so, it queues the skb without transmitting it
> immediately and schedules deferred work to handle the transmission
> later.
> 
> A rough implementation could be:
> 
> static void send_udp(struct netconsole_target *nt, const char *msg, int len) {
> 
> 	/* get the SKB that is already populated, with all the headers
> 	 * and ready to be sent
> 	 */
> 	struct sk_buff = netpoll_get_skb(&nt->np, msg, len);
> 
> 	if (in_irq()) {
> 		skb_queue_tail(&np->delayed_queue, skb);
> 		schedule_delayed_work(flush_delayed_queue, 0);
> 		return;
> 	}
> 
> 	return __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
> }
> 
> This approach does not require additional memory or extra data copying,
> since copying from the printk buffer to the skb must be performed
> regardless.
> 
> The main drawback is a slight delay for messages sent from within an IRQ
> context, though I believe such cases are infrequent.
>
> We could potentially also perform the flush from softirq context, which
> would help reduce this latency further.

If we take an OOPS in any IRQ, I suspect that delayed_work will never
get a chance to run, and we'll now lose all such OOPSes over netconsole?
I don't think softirq would get a chance either in that case?

Clearly, if it was a net driver's IRQ, that's not likely to happen
anyway. But in my experience, OOPSes in IRQs other than the driver
underlying netconsole's netdev *do* get emitted pretty reliably.

If your condition instead becomes:

    if (in_irq() && !oops_in_progress)

...I think we can have our cake and eat it too? In an OOPS we're
busting locks and such, all bets are off anyway. Although, I suppose
that might still drop messages emitted immediately before it...

