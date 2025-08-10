Return-Path: <linux-kernel+bounces-761457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FBB1FA4A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36EE178B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661025EF97;
	Sun, 10 Aug 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="U6melqi+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD342475F7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833827; cv=none; b=U8lf+iSGT00zNxQEcMcAk38ma3LW/9r41Z+io5fnqFTCPQfnux91zx66AfoqP1hwbGUy4TZxkHmJQLT+TDr2R0KRBJ/v5OOz7+EJyMpcL9QJIefeF17zL6/nr4+CjVFw3HX7OC+VBArz1lDhkHzCxCvqhEe2tV7POuBfY0d2NkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833827; c=relaxed/simple;
	bh=p7BsbrGAmeMQfqoDvx2nZTX6wg9kIycv6VZ0kixKOJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuQs1IKCRWnTCwklIdrZTSNQn3B1yCY0EIAi2V1OhwImiZvDgyDlsbyxTyu6r+blHL5LFEDYF9Vw10w1FJuq2fCAjrIbvgsYJsiFhASvXqS8I+RQs611mTQNcIx/bDli+YWD9F0SfB/u6NFVykN++cB2Gt03ecnBSW1H/JnlLOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=U6melqi+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24009eeb2a7so31224865ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754833826; x=1755438626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEJoriNDa5rnMjLc9ZXlpdYdb6v5lPl2Mbkc+ZGNcbk=;
        b=U6melqi+MzSUKfUE9ovqN5bJ23rejO1JDxIecibUEd3O8cx6TTnvxd+61g97jj6DSq
         a9VT8lm5r2EmVgvFUDggjsKY6iIoqGU753Sm25+LDER5n0rahvDWu5j/E1m/OLg4BgeM
         +EXpm+hArXaHO2TP7dvmu2FQDEn9nJYlUWUJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754833826; x=1755438626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEJoriNDa5rnMjLc9ZXlpdYdb6v5lPl2Mbkc+ZGNcbk=;
        b=eWYvTQcqEeWM5gHNt/dFYu19wIzmDLIviAQPIm1RwSYQkiVG9JVoUZ+DxyZNKM4WdF
         ii4CzQ216Zr1QRKD7oOy1NCbOgziHVSdnFZPPvlab627JB8HBaGxGTxzyMdPzCfDLSrp
         v98P30bivB7k725oq1tbA6TRm1/5OIghqUnkaqvMq80UFMC6RQff1nfFcDC7jO9WsRqX
         8o5PGddPuWWW4a83T+bdTLYVpVkii0DpM3lnRElN+GcWKhMto9Ag6OoZJJZ7NO3oBguu
         U6u+Ufu8LHSvbUMN9Q5iU5RpmbKPSH3YZ9CVho0npzeWfeIF/S70lih6J8YL+oP8el5L
         Pghw==
X-Forwarded-Encrypted: i=1; AJvYcCW7r0Bl//9oLQI8hQgv4XU5bQJOzGlEm78QAl/VuzBDWSYRpH0c0xWcRYplQfC4zzW/3S4xPJvPEYpdks0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/unbfv30uy2SRxGo/TCDIkpb6t82Xzx+fOWkR4+DQEB6/r1Tp
	Q2NEaB8NuJqPI+M9391upIAnL5yB+IfXrntNv6YMV5ZoRPeCdKle+krTfaOM8O9jsxw=
X-Gm-Gg: ASbGnctqEm/rOOwYzAaQTrr6ynelbyZCVN/+wjdbs3BX8gYG3qO1jLgPNprCuemK/PG
	1MLi2qsnUD5atZOOKK7onXfPDAec7eqT2L1bsy81GCv6tzLDVtxVrS8f92F7+6EeuBIgfnwQpA2
	OA40BwA3PzPOF2Lu3Ok3A/5eYXFwRTgcoLMTGHdOEqwNH3rgD6HfsrCxxwRHiDrMus02c/7eC6l
	HXmMo0jH75hF1EYZ+TKkCJ8uCBd1GsuIOQCUxchb5xs51GaY0y6d7U8llpLo4yohTWyu+yIWIyu
	5lRPfKemGHu4C5LRgLwQuwYFVVuGRAlLQRbfSFgvdl/wCEnRM/eK4/J/PboVTr8DQWpJvC7eEfg
	0TexKZACnVRfIYPEAwfgCtJU60RCv9sgOWGmh+YTi6sl79VGSt3be2AH8
X-Google-Smtp-Source: AGHT+IENp31HkWj826CiJ1+k4dxYMOt11EipK3CH7vyGbmZkeyW3/TjnLaKgr24R7x7nzGfXFeZ0iQ==
X-Received: by 2002:a17:902:d486:b0:240:a21c:89a6 with SMTP id d9443c01a7336-242c2003830mr150469815ad.12.1754833825790;
        Sun, 10 Aug 2025 06:50:25 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7557sm249307295ad.19.2025.08.10.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 06:50:25 -0700 (PDT)
Date: Sun, 10 Aug 2025 22:50:07 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Benno Lossin <lossin@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] rust: io_uring: introduce rust abstraction
 for io-uring cmd
Message-ID: <aJijj4kiMV9yxOrM@sidongui-MacBookPro.local>
References: <D6CDE1A5-879F-49B1-9E10-2998D04B678F@collabora.com>
 <DBRVVTJ5LDV2.2NHTJ4S490N8@kernel.org>
 <949A27C5-1535-48D1-BE7E-F7E366A49A52@collabora.com>
 <DBVDWWHX8UY7.TG5OHXBZM2OX@kernel.org>
 <aJWfl87T3wehIviV@sidongui-MacBookPro.local>
 <DBWX0L4LIOF6.1AVJJV0SMDQ3P@kernel.org>
 <aJXG3wPf9W3usEj2@sidongui-MacBookPro.local>
 <DBXTJQ27RY6K.1R6KUNEXF008N@kernel.org>
 <aJdEbFI2FqSCBt9L@sidongui-MacBookPro.local>
 <DBY6DMQYZ2CL.2P0LZO2HF13MJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBY6DMQYZ2CL.2P0LZO2HF13MJ@kernel.org>

On Sat, Aug 09, 2025 at 10:22:06PM +0200, Benno Lossin wrote:
> On Sat Aug 9, 2025 at 2:51 PM CEST, Sidong Yang wrote:
> > On Sat, Aug 09, 2025 at 12:18:49PM +0200, Benno Lossin wrote:
> >> We'd need to ensure that `borrow_pdu` can only be called if `store_pdu`
> >> has been called before. Is there any way we can just ensure that pdu is
> >> always initialized? Like a callback that's called once, before the value
> >> is used at all?
> >
> > I've thought about this. As Celab said, returning `&mut MaybeUninit<[u8;32]> is
> > simple and best. Only driver knows it's initialized. There is no way to
> > check whether it's initialized with reading the pdu. The best way is to return
> > `&mut MaybeUninit<[u8;32]>` and driver initializes it in first time. After 
> > init, driver knows it's guranteed that it's initialized so it could call 
> > `assume_init_mut()`. And casting to other struct is another problem. The driver
> > is responsible for determining how to interpret the PDU, whether by using it
> > directly as a byte array or by performing an unsafe cast to another struct.
> 
> But then drivers will have to use `unsafe` & possibly cast the slice to
> a struct? I think that's bad design since we try to avoid unsafe code in
> drivers as much as possible. Couldn't we try to ensure from the
> abstraction side that any time you create such an object, the driver
> needs to provide the pdu data? Or we could make it implement `Default`
> and then set it to that before handing it to the driver.

pdu data is [u8; 32] memory space that driver can borrow. this has two kind of
issues. The one is that the array is not initialized and another one is it's
array type that driver should cast it to private data structure unsafely.
The first one could be resolved with returning `&mut MaybeUninit<>`. And the
second one, casting issue, is remaining. 

It seems that we need new unsafe trait like below:

/// Pdu should be... repr C or transparent, sizeof <= 20
unsafe trait Pdu: Sized {}

/// Returning to casted Pdu type T
pub fn pdu<T: Pdu>(&mut self) -> &mut MaybeUninit<T>

I think it is like bytemuck::Pod trait. Pod meaning plain old data.

Thanks,
Sidong


> 
> ---
> Cheers,
> Benno

