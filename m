Return-Path: <linux-kernel+bounces-723881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B0AFEBF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698CC17FCB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FE17A586;
	Wed,  9 Jul 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="cE/GtvM9"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895352E426B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071247; cv=none; b=sakwumM+2SKy0lYkrPd0G7CPsrvGjz9XiyydWTy9TcnCJeb/B8Itd9P0o+NNrC0Jy6F8UMy6MCoopcN+liWsAecPQugrXVQK+RzEBpTKzBfZ468Cot7CFnAvAoo31RPNA++U22EOYLuQOf6K0JxFQN9y0gAjUbDm+0skT//pEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071247; c=relaxed/simple;
	bh=fi5dlcVYm9G8nBwLPH0im4WpK5MxfdoRzaSmVtausTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGrZPS2jpxsNnAJZ5pgejdNds1oBpNtIHf8Ts+O7DFC8VuJaga/piJ+Im+kBR/VpYJ8Y3Tjy+GDxuGX5vpqCivSmNC0Hw9TehUo7upLlGng2+YIyWpnSPQor1CDOQU7/9nucwO57gBD+dn7DtxXBC0rDF/9uyswz7lNt3KR3V9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=cE/GtvM9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3f5796755so538962085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752071244; x=1752676044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGWFHdtZblo8Oo2gBKGyoEbqM+fNtoacUTFg5r7huRI=;
        b=cE/GtvM977DTKr3Kb38XbrgRpXOsCZps2eqfxycd2dK8r3xEJuBCQKwjlVTZLKtIZp
         yEB84+eLNgiHT/5We13qNUem6cdzjH1oaIOjKMSdw6lYHDT9utHDUAX6ip+K+BdeEEGH
         aNuMmWp/9/tKOrN2Mto9HrrFAf8iySyI3dsGNZ5HGmBNiWOSGK+IC1KijfPYf4Y6Jwp2
         YN32dKKJqpNTQ34yCyyuVSRmrWFTCUlUnn3YmVwQhSYOfX7rPQhnKFeKlzv8tTJHD7ND
         dEzlSW8N2ugZ3Jt75BXQ8xyu8UPqKaJ0fsNt8wQxOB/xwrpMNVDcMojV85OziOcszEAw
         UE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071244; x=1752676044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGWFHdtZblo8Oo2gBKGyoEbqM+fNtoacUTFg5r7huRI=;
        b=TwIMQJZEfTcjjpEP0Pltp1RtxiNweN5yfbXYaHKtv7IXJ6U8DNx5f4R6MnOTqf9Z52
         SMT/586KDxv8b3DBk5y1fWzeLgl/URzURAccXhX28h/YHOBw15OPVr9hPrx+61Saay4k
         pVrr6uec2TyIWp/hlSmuhNExOVQXXvK0P6pgWizc3CyPncaqw7Gc4ExDzWbPmJpNZ4w1
         zVRPejYcOfWG9QXVQ7Atim1bLYWBNTDmApTr9s2PisgJcugwwkOoSbTYRG7rEvyemBif
         EsQslgj6uXLLUGSPq1PofJol4Uymz9voFYJYAUFVGn1NzTbA5Eplqq//XmiR0t6V8Uvs
         s7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUsb70C927Xd6TJDBaBxDV5q4wgEsI08dFsE4PVB8R9UujQv3s4YDfgJ+9EZ9Pck9O48FrvRXRmOJzo7mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9a1Emm/X1YLeWRYw/sSWfpSq4ygzrmYB3EfpqrhwF9fv3FE/V
	kk+4kpXc1hRc/buLo71ECFjb6BtilZ4SJR+XemCBsQEoTYoj6eBlEUIKTt8QmTgl7A==
X-Gm-Gg: ASbGncuVQF2JoSXnPQ7a0Xryu5EV2zHqVDVo16XySGh/u44Jun0Ai856QL2BKbJvb9F
	AM0KAPuW3Puw3+PCxooQl5qVeoirBpdqHp0QnEJnQgX7cvW5Fa6UwxZgLZReS9lc5VKH9iuaSL/
	kmfolIiM9LPUXL9aiXvgAWIRFgbzKWVPpOTlIdbk0vV1KVo5ERCIhUGwxxnk53SKaI1y8oiSPUj
	9SfJPESw5vTtu88GBP+OiZOehS7KakRdLc+uDlxkQELi6ExkHCYI5Ly17odpczRrM70726AZGBF
	42fejjdJzAOdStq6oRVRoGbbCBQ8RMWiUAWR6Qvisj04yDs6p3D+DKV0rI/BjHovJN+OUARojo3
	LaYxl
X-Google-Smtp-Source: AGHT+IEhSNilAiMzk7JU3mAp9mY4ZZ21aK9Lgnm792fBqwVqVQMNtgq7u9pI5px+tE6tp9YuqMqxVQ==
X-Received: by 2002:a05:620a:1a0c:b0:7d4:6257:3a0b with SMTP id af79cd13be357-7db80d7707amr417464585a.54.1752071244413;
        Wed, 09 Jul 2025 07:27:24 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb2318sm938003185a.107.2025.07.09.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:27:23 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:27:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	USB list <linux-usb@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
Message-ID: <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>

On Wed, Jul 09, 2025 at 11:13:29PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> I tried below change (in case somebody is by error passing
> out-of-range values) and hit this BUG_ON().
> 
> Did I use wrong boundary condition?
> Are there exceptions where out-of-range values make sense?
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 92c752f5446f..baf536c56c21 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1985,6 +1985,9 @@ void usb_sg_wait(struct usb_sg_request *io);
>  static inline unsigned int __create_pipe(struct usb_device *dev,
>  		unsigned int endpoint)
>  {
> +	BUG_ON(dev->devnum < 0);
> +	BUG_ON(dev->devnum > 0x7F);
> +	BUG_ON(endpoint > 0xF);
>  	return (dev->devnum << 8) | (endpoint << 15);
>  }

Which of these three BUG_ON's did you hit, and where did you hit it?

Alan Stern

