Return-Path: <linux-kernel+bounces-738536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C4B0B9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C721896AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312218BC0C;
	Mon, 21 Jul 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="svI5CWy7"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23D7260A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753061364; cv=none; b=kJ3WVzqkYzV1qHtG2RHHNyu4KnPQb/eAHFJzFfc7ggH/fO9b0Vjp7ClsHsDCqrBKa9n3w5jCdret7zwTsQcmU5Ccavw53LfVtG1LH2/CZgoioj8AcUF/0lmNlb0kh7PIFnFYwhJmsSbHHhJkQNIcXcFVCbEQaRlkaQlcfj+GdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753061364; c=relaxed/simple;
	bh=qUZPqaVQzdx+KR3dhpj0J+Z89UTpW4E+eqFQDjtcZbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyQ3xWMsQrkQRSmzUO1aiI84PBP5p8YFpUqwFsomqCcSWHVxp1WoGzIs4tG5PHcNNFctQ1FazFNRShJfl5w0UqmYKkEtAfb3ty/Sxh38f7diI138YNalrSP+Ao2spwtDvn2H+8zcHoIkydv4cUYqD9dJdhy4BQi2Aq5Gn2POoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=svI5CWy7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab5e2ae630so45718031cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753061361; x=1753666161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhntmyEypSEejVoCJCB83K3S3THmRRLjvAqFcWpLdTg=;
        b=svI5CWy75M3nxeqoRbw8tNSf5j4TxDfSdxIQKTh+PElgFupxwN+SJ/SkJvBMMBq3wX
         tagCWFOjZ9EbRUFexXD+05Y8jYDF8HcUZLfDayPpkkYfGO63gehIKv+TM/RJL/9phOO1
         hyp0/TSOCza0UkUMM33BoM9XufvW4O9UK2DtVn2QBW3FgpU93+kl4n4VJlCwhyyxooi7
         jXCAdyAZkTTla2aQ6IpqwMKepMAsapscvSy8rZtIAJowfIR/mdLofuHMPNbuKAt+0hcX
         q3xd5wOXGygyZk14Su2yHhNLbYV7QguvsvICXhIhO1OS7MK/52l3Hkbjqfmz+U7nW45Q
         yUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753061361; x=1753666161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhntmyEypSEejVoCJCB83K3S3THmRRLjvAqFcWpLdTg=;
        b=cfVjDgAZoKRz3uAwmpEh0OO74SrFS5vvXQI7GMfXrUMLknVdywlzQY6XS/xxBkioZW
         y/Hc5417sjUjAvTwC8Fk9XgGcND4cAE+qJbtOW3ky24uv0GxEkmBRJuSdUMYc07ie+Ym
         QneBw+VRGEUtK8xoJnHrhPl5+SCWDeAokXNSwth89V0cu7SJhH6Lcj0hTH8PU9qZPN/k
         e1jW8KUEGQPBIks/hwilmoEfQvE8QPzUHTObF9ZCuQmeHx8KTlNWl7c2vhh21oWRVjt/
         22v0r2G2FWsRzoB8E50CTk9Ck6T6ERfCNGm3vDJ7GNgAby8psWry7h8P8Vu6qF1KWKfX
         k19g==
X-Forwarded-Encrypted: i=1; AJvYcCWa7SGsTGlLguuAjLQJgYGXeR7gpcYmPDF6DrKJI5r0w0H/h0BFahVaKxw6ANdL6YpMU+61n+a05xKDpUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UqxjNm5IM8r9eLmlmspKmqlu166jo8bd8LJUEvZLSXjMOX5p
	uKBRMgoxEzTfT4IPRcd71UXF8qEPZ33eszDe28sD0WiL/FsetFM4O2LApZvgnIEA5Q==
X-Gm-Gg: ASbGnctwmjBb0Ikby/eZgeM6FS5x1Iu0tAf8WFK2InAytI4jKpYflfYUyHG/ELkFmoF
	kn18xnCLFID4AleIzvTc4q+hb/uJiigktA7g29DLbVp9zm2RLoMDcg4oTznFgNSoFhczQQ6oYT3
	IsoP890t9dtOGpq1URSaOcfiIbdCTR7Az9IHK2qQdAi4KAVMcJKiJvytSuZP905uofCFU/xMZvw
	ykzDiZjL9gwGn/rg9YAxwKKa7MJNgQo5Z+MdqRwwzdve0kq9SQOUZnh69dMItExZsPz0xwkGDbS
	X5p9LrxgnidisRX5vX4Ziz8gc+RkXPu7i9gdjn+abdKXaWqbBsr5HdAn/yHz1thlkVkUCXbgHMb
	O9VUPlMixCBdEdtKvDABp66g=
X-Google-Smtp-Source: AGHT+IGvZXN48xypC7e8hnBaSBqC9wAa/B1Fi8eCElwg2pmL3DV1fODaHlgST8LHhtda82WAIIis8g==
X-Received: by 2002:a05:622a:1bab:b0:4ab:85a5:bf05 with SMTP id d75a77b69052e-4ab93dd693bmr259861401cf.45.1753061361320;
        Sun, 20 Jul 2025 18:29:21 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb497fe88sm36655191cf.5.2025.07.20.18.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 18:29:20 -0700 (PDT)
Date: Sun, 20 Jul 2025 21:29:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	snovitoll@gmail.com,
	syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: mon: Fix slab-out-of-bounds in mon_bin_event due to
 unsafe URB transfer_buffer access
Message-ID: <8bbc84ee-44c9-4a85-b5bf-3980b3c81e5c@rowland.harvard.edu>
References: <20250720200057.19720-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720200057.19720-1-contact@arnaud-lcm.com>

On Sun, Jul 20, 2025 at 09:00:57PM +0100, Arnaud Lecomte wrote:
> The syzkaller fuzzer uncovered a kernel slab-out-of-bounds
>  write in the USB monitoring subsystem (mon_bin) when handling
>  a malformed URB (USB Request Block) with the following properties:
>  - transfer_buffer_length = 0xffff
>  - actual_length = 0x0 (no data transferred)
>  - number_of_packets = 0x0 (non-isochronous transfer)

This kind of problem is fixed not by changing the way mon_bin reacts to 
malformed URBs, but rather by correcting the code that creates the URBs 
in the first place so that they won't be malformed.

> When reaching the mon_copy_to_buff function,
>  we will try to copy into the mon rp bin with the following parameters:
> off=0xcc0, from=0xffff8880246df5e1 "", length=0xf000
> 
> At the first iteration, the step_len is 0x340 and it is during the mem_cpy
> that the slab-out-of-bounds happens.
> As step_len < transfer_buffer_length, we can deduce that it is related
>  to an issue with the transfer_buffer being invalid.
> The patch proposes a safe access to the kernel
>  kernel buffer urb->transfer_buffer with `copy_from_kernel_nofault`.
> 
> Reported-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
> Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
> Closes: https://syzkaller.appspot.com/bug?extid=86b6d7c8bcc66747c505
> Tested-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---

This is unnecessary.  The underlying cause of the problem was fixed by 
commit 0d0777ccaa2d ("HID: core: ensure __hid_request reserves the 
report ID as the first byte") in the HID tree.

Alan Stern

