Return-Path: <linux-kernel+bounces-745982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2EB12134
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA02173FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645F2EE988;
	Fri, 25 Jul 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="XZHBVXTf"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AA19F127
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458388; cv=none; b=RbunwEE3w1OJLdOCzQ9+dLL7VGBwGyM1IREjnivTe4lho5Y5muEEoD4ZK83QRA1ia9T8ZB9TpqF1A7HgDZ62LVb1n7zOwQU9bysm96WlDH4XScVt8oDQKJOJ2vn5bwrH1jo6h0jAKsNNNZsQtaki/wLM6gDzfCBx/21E5N6zBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458388; c=relaxed/simple;
	bh=xaAQ3LDJdVzcBZAOp8TyIGGpL+K0F6NWz8bQF08EGos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnt08Br+EatR3kt6mhrwasYaA8dCNQFqzBr9MwdxKP7Zm5uN2Jdnq/wnJYFeFwHk87zN44tfVCm4ddsGpFdxssFarM82E3kzFcJMM3fAvZYF0yI+dhIyQL8o2f1S9T7V9aljDaeH+87mcYj3K7xjU5+BypXuKPxeOjaGe8vbXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=XZHBVXTf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-700fee04941so21310656d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753458385; x=1754063185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WGkkRv2unyWM0ZloZk6dP7Gl6edx2qC7G/ZfqKk8Fg=;
        b=XZHBVXTfY1yVBPZ2B6aHrHvioC8UEbMBKPnuymQ8qjY4EBwDrk7OaS4lTaIIU98qUg
         19bkAc2WDtaH/ykPUnxBIkw/n1y/LMGfvqeY4uhKhx4R+znvk3P7vLtBlCIpjiAzPsL1
         WXxHQ3i+NRaWIkgxdFvpsYclGgG9/KGC9t2yyM6IE/EPrSh2FXQ/qp/Tjy3rMC7foW6r
         bUjCcbeks7SEqcSwag1CddYoLFpRS2WO5+2GogeyXsLeUIHN8cu0bcwP1bvbR+edjG1G
         I1iUF8T6iWvuMIsZI0ZdgGRZgsjKS7VuCOxBxRjEzfDMV2nz9E4fiwrQS4tfy/5lyWoZ
         KRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458385; x=1754063185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WGkkRv2unyWM0ZloZk6dP7Gl6edx2qC7G/ZfqKk8Fg=;
        b=G3s9oSu/pHuGZ+lwAWZ3qTYyaImIGaTLTkjgM/LATwMoTgK0YTaZBrMuZZ4OBOyE5/
         r3VZM7x3Q5UXwzdxIMBwtx5Sib75E7MGHB084qhnITvHIGO8v5G8ZUDYBjVvgKvY30f0
         R3QaOMcqzvoGBkvFrGQ2z0w5QJwLphaiOdf1RAzjT1e+4WGtDXVy2XXU8dTU8U/wqHjt
         ZnU69iHTcT1nulQPr4tBp0e9+c5oXmU+JeE3aKY2v12ww7iLxxjaG3GxNI6Yut8ynokR
         W0epcKW9tjmWMGT1vlfljfDaWnX8IXrXeYA+dqs2CT3J3fcqH5qjiGb5l0rimWOTtGNx
         HCTA==
X-Forwarded-Encrypted: i=1; AJvYcCVuSvn+xm+F6wI3sBTAggjU5aVb8t+fRZC+aw6LTkm8x4XZKVWT3OJqXfFUtKdke37o6UG72CPS9GJoM/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRbz8PJoemqEooGQEAyPgW51ppDZJhF/uadN1qALN6RqWpAVH
	Fid40QOKuKx4Q4D3ZiO3wm6loi8OKHwO1Hgybtz9b3thqXpsKGtcEgyCf2Y+RHX8Eg==
X-Gm-Gg: ASbGncs0ee5ZdaQ8cYYTsv7aGXR2Un3ANSGM/o8NjbRACgTwLa6vQ/1IbvJ9ysBu+Lu
	s2FV35Qe4rS96NVwgbdnpLjROhaAR8pifgIuNHmh40/nXFwkHxww/YiblNzdtPdWX32YdiVURF9
	gfiHvtfcmFSznuosaek0XuRgY3qoALloEXVawICSVw3rQ+E7DiMHXbEnnkh/ApWnq5qY4HgVx2k
	K+pK/JUx/ArC5NEtgzBNWjEaT0nBBz4HSqZ2o5mauF0QjLTKHIX5U4A/+OYb13TbEdgJBEBVTT8
	SC0rO92ZDuv6qUPHZiC/Z3fhCEbN8I6WJ70bTNvYqXjFQYSBsXiUf/31ICgltJ6xhu5DqVB84oG
	MZ/Df+Nm4SOEI+IixxyuQSSU=
X-Google-Smtp-Source: AGHT+IFmcN98ndZL6dSlLYKVAJOxau4Bo9pL2GEN5zNkwJGM5vAV48zrntjB9XCXsgxhTMHkCGaIjQ==
X-Received: by 2002:a05:6214:248d:b0:6ff:b41b:b5bb with SMTP id 6a1803df08f44-707205b404cmr32909726d6.26.1753458384960;
        Fri, 25 Jul 2025 08:46:24 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::317e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729a63240sm1574636d6.27.2025.07.25.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:46:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:46:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Olivier Tuchon <tcn@google.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Add gadgetmon traffic monitor
Message-ID: <42f4753a-f7db-49a3-ba40-8743a78684b4@rowland.harvard.edu>
References: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:25:49PM +0200, Olivier Tuchon wrote:
> The Linux kernel lacks a tool equivalent to usbmon for the gadget side,
> making it difficult to debug the lifecycle and performance of usb_requests.
> This forces developers into using ad-hoc printk statements for
> introspection.
> 
> This commit introduces "gadgetmon", a comprehensive framework for
> monitoring USB gadget traffic. It consists of two main parts: a new
> monitoring interface in the UDC core and a loadable module that
> implements this interface to provide data to userspace.
> 
> The UDC core is modified to add an optional monitoring interface defined
> by struct usb_gadget_mon_operations in <linux/usb/gadget.h>.

This does not appear in the patch.  Was it left out by mistake?

>  An
> RCU-protected global pointer, gadget_mon_ops, is defined and exported
> to allow monitoring modules to register. Hooks are placed in
> usb_ep_queue() and usb_gadget_giveback_request() to call this interface,
> capturing request submission and completion events.

Do you expect that other gadget monitoring modules will be written?
If they are, assignment to the global pointer should be handled by a
routine in the gadget core, not in the monitoring module as done here.

> + /*
> + * optimization: for an OUT submission (host-to-device), the data
> + * has not yet arrived from the host. The buffer is an empty
> + * placeholder, so its content is not captured to save space.
> + */
> + if (event_type == GADGETMON_EVENT_SUBMIT && hdr.dir == USB_DIR_OUT)
> + payload_len = 0;

There should be a similar optimization for IN givebacks.  The data to
be transferred to the host was already recorded by the submission
hook, so you can save space by not copying it a second time during the
giveback.

> +
> + hdr.data_len = payload_len;
> + total_len = sizeof(hdr) + payload_len;
> +
> + /* lock and queue the event into the FIFO */
> + spin_lock_irqsave(&mon_lock, flags);
> +
> + if (kfifo_avail(&mon_fifo) < total_len) {
> + /* not enough space, drop the event silently */

Would it be better to keep the event but drop the tail end of the data?

Alan Stern

