Return-Path: <linux-kernel+bounces-811449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67782B5293C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E683B888A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961D258CF7;
	Thu, 11 Sep 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8miqO8M"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3E3C17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573446; cv=none; b=H19SJ6UBVif0wccNhROhJLTDJOrUP0KRx7bdm27uC2h0ms8lhp3tOrsSm9vGpnNIxmpsPcKsMPhmn2e4fQO/owIXTy+GQPyvtT9u16Lz8vUwnyduRLhzY0jUekk/5L8EQJeVYWIIofzlo3nYLOqlemJNkpDRjfw5ooe+jyGb2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573446; c=relaxed/simple;
	bh=Qmej7+PbGLzKdrf5NwREGPDWn8BnQ+ox2SidyFmQdxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvEjkOO51E9DoMy06MV7qufPpMkXAIc3LwbQYzhdXD1nki2ttXoTJvPHUA6KCaqDCpwoOdvoNQZlc9REH2Dy8IuOFAbg0AatySdDnMLi2wz8HCbsaVBhqZpmbJzJuNlUEy1cyeMQn7HYxkKYDSrm52ChXzXBOUZ1ihplu8NwX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8miqO8M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45de2856648so38615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757573442; x=1758178242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYiFEl1cKyTzdaxqboCqwBqA3eL+ISbCaMPkWSxLypQ=;
        b=g8miqO8MH7v0Sh2srPCNhFG9xWSnHgiVS+YO6GPjGEQFxbceLY1h0O//4pI2jxVmr7
         gLUgW5gc4V4Si2l6IhOTWF+pER28TGXEx+YbY2ymCnwAN3hRlTOSysH5idEJsRuLoX32
         vKcVDFbfTcSVTlII87VzYGJ2+HCH5qTcAXcboRYPZViCBXzulSPe7l/nyYscc9uNGmJb
         +OL6I0xW8cm9ogUsqYFbqIRo57MkR72e5DQned7q8aj0E3Vqkzsexp+UgDkE8u2Gv/Mj
         M8vBBPURMZoIGn1YFUAKAti0sEpEvlb/D8Vw+DPT5UYTou0qpSzZxFL4eBwW8UdV3fTD
         V9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573442; x=1758178242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYiFEl1cKyTzdaxqboCqwBqA3eL+ISbCaMPkWSxLypQ=;
        b=fvIHhxQvqThZtiWApC/KWHu5+G1HHFpGAoBkYI2cWDRFzF5vqhdsoA8EieUXnvmKou
         hPGlb3VDkQo54NO7Eh3ruY0W5nvmf1ory1c4wm5FcqpRZv97GqT0lxefSsBhd7mNm+hY
         tp6tZzcHESnQQ2JRXGUGql2iPiRNzq4LleyIvfJ8bWt1/IuYhFwTHF3zf7KWmnYWHer+
         TqEHywQ11qHftdRWUP8HnnKjdRoIgF+N4pvuAb+rTC0hbVKX8AORbK4xQl9x3tB3iYH4
         kIoBvf5HpH6dbH5ZEIJv9HqNrZ0lZu129kxzbUqtq505oIDA666aSBCFll/w4v4fE/7x
         PzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXglNy5lf3S1MSGwO9kqmwqVBCai50G7QmbN2f5mC7znsB3It18AE1obF4bSHQ3Z9pUMaSGgJfsQ35fWVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGbD0pjCZk2XNM2er0m2JppLGCwSSPIQWLcYzEittgoHBmqAo
	LDMSRN3vZdoxBeBe23yPUhYMXAMq9dEOtP/3DxaCN1RVRdq3/TJgKuU686oKoo3sPUn4cB5hA3u
	dNrs+7FenP5R4BIe9NjFMf1Fe32MP3hEoEfR0K+K6
X-Gm-Gg: ASbGncvijT3wW8FsxwhkKK1oeuQCAIelq6fDRj29rX/7kFX9r/bUIcKA2uF3QNLsD5K
	e2ilvEyVpm9qvPWLUL8GldF7b0abR12+cpRQQT8juPQHI501ytnlKAVZOGmRn4JB33pvSlY87Lq
	VPqb8HerxGzoSp+sUJnxDQ8ThlkPKp4wxXgnZyvGF8CgSS/CyOo2MYybr0WboaI8daDnz+irGos
	f0M/wVh4VvOMTiarDDVCLzIPNEMhcGnb0CG6MQT
X-Google-Smtp-Source: AGHT+IFJbf1IyXGBCFdg7upsR0ji8KKP+f1JtPl42/vxHPTsLQ1LycUtAnMTQe1qYHPH1lEHLbkyiQchIBkA8tyrg54=
X-Received: by 2002:a05:600c:12c9:b0:45d:cfca:a92d with SMTP id
 5b1f17b1804b1-45df74af1b6mr2252505e9.2.1757573442443; Wed, 10 Sep 2025
 23:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904114854.1913155-1-khtsai@google.com> <2025090651-unifier-award-3e0a@gregkh>
In-Reply-To: <2025090651-unifier-award-3e0a@gregkh>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Thu, 11 Sep 2025 14:50:15 +0800
X-Gm-Features: AS18NWAMPsNVcx8vukdIJf2WC9FuB49krMkFwHqi-L2lEbkeXdxFuuWz00OB9vc
Message-ID: <CAKzKK0oi85bnyT3Lq_TXz8YwFrmBxQd8K1q7hRDv-Oww75F_tQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix NPE in ncm_bind error path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: zack.rusin@broadcom.com, krzysztof.kozlowski@linaro.org, 
	namcao@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, Sep 6, 2025 at 8:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Sep 04, 2025 at 07:46:13PM +0800, Kuen-Han Tsai wrote:
> > When an ncm_bind/unbind cycle occurs, the ncm->notify_req pointer is
> > left pointing to a stale address. If a subsequent call to ncm_bind()
> > fails to allocate the endpoints, the function jumps to the unified erro=
r
> > label. The cleanup code sees the stale ncm->notify_req pointer and call=
s
> > usb_ep_free_request().
> >
> > This results in a NPE because it attempts to access the free_request
> > function through the endpoint's operations table (ep->ops), which is
> > NULL.
> >
> > Refactor the error path to use cascading goto labels, ensuring that
> > resources are freed in reverse order of allocation. Besides, explicitly
> > set pointers to NULL after freeing them.
>
> Why must the pointers be set to NULL?  What is checking and requiring
> that?

I set them to null as a standard safety measure to prevent potential
use-after-free issues. I can remove it if you prefer.

>
> And this unwinding is tailor-made for the guard() type of logic, why not
> convert this code to do that instead, which will fix all of these bugs
> automatically, right?

The __free() cleanup mechanism is unfortunately infeasible in this
case. The usb_ep_free_request(ep, req) requires two parameters, but
the automatic cleanup mechanism only needs one: the resource being
freed.

Since the struct usb_request doesn't contain the pointer to its
associated endpoint, the @free function cannot retrieve the ep pointer
it needs for the cleanup call.  We would need to add an endpoint
pointer to usb_request to make it work. However, this will be a
significant change and we might also need to refactor drivers that use
the usb_ep_free_request(ep, req), usb_ep_queue(ep, req) and
usb_ep_dequeue(ep, req) as the endpoint parameter is no longer needed.

I also want to point out that this bug isn't specific to the f_ncm
driver. The f_acm, f_rndis and f_ecm are also vulnerable because their
bind paths have the same flaw. We have already observed this issue in
both f_ncm and f_acm on Android devices.

My plan was to merge this fix for f_ncm first and then apply the same
pattern to the other affected drivers. However, I am happy to have a
more thorough design discussion if you feel using __free()/guard()
automatic cleanup is the better path forward.

Regards,
Kuen-Han

