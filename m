Return-Path: <linux-kernel+bounces-764991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB104B229AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C029685996
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0245C0B;
	Tue, 12 Aug 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="m06qHcBU"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D9283CBE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007002; cv=none; b=pNGLQPpwsKupICCgwYl1ZDTccpuL5ncCN5GgQugPnvSblYr+pFVF02/hrJxDSLIQzi8mo3ozyHA9f4phgNlqn2ZHKRpJrFit1MHPE30IXHiUkcUUYthFbQJGScgM2rbxCw+eIZj6bYHfOItLg1v6GXx0HxKr9cfWSmhrgof02cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007002; c=relaxed/simple;
	bh=ifkzomFcpe8Uk7XzdkvoUVDkTw4hMSjtDB5FJ9Qmx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4fQaypqh5KensfluWDnZxNzJLqD8FGMdOEE1t0GT588PLT1Guj6LUOSRXEv1DoyaaIPmP4rV+dQ/NVXlwB+dKsU5dOJM4cYqkRVCtGTCrfVMLDpeXZVPsJe0Q6djvj4BdEKOkAcrxmCeV+MgWw0U52HPf3Khzjm056KJYKcwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=m06qHcBU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74264d1832eso6828654b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755007000; x=1755611800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muKLwWTItd7PcxJ11Sn7699T3U4KoLGnLzfODwqe2/A=;
        b=m06qHcBUPUkPApxzhyazxvG8qlGhCQXNCm8OqVhme11sSm3VYkdanpMEazkf0x/ONt
         lrliVE8mKI9CA0xnbcTdompF0cSyBWcsESixCTosasyddRYO7Njl4NRU8sJ2vt7Vdz3S
         FOjNNQvoPoiguHclIO0uvbu2ufVh6YxIgDTUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755007000; x=1755611800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muKLwWTItd7PcxJ11Sn7699T3U4KoLGnLzfODwqe2/A=;
        b=VLezA+Y+cAf9Zlz/FNTI7i+Ss7VoaBiVAWVT9rXPEVTTutZsnEQH0yKneK471acgL/
         +DNAk+VVms7g3bP6SOoDSmQKMYMh3JJ/EVWbk4IWDEr0N9uB6DIazzvgHhqDH27G7GIC
         ez3j2iWS6/K8+Mr4trC8/OacQvKFn4dDLijgGJoF07rxWkatrryBSr9UH8M5+K85eDiL
         4nuIACdmQfhXM3SPTQncaK8NISdtqP6ytmD98ozC941pXHGfVUSBqZ9788UVQUcgsU5t
         aJBVhwq+39yqjqbrpaEc+4hQtn2rWC17+NOoo1B661d4DBbsCmV3i7E0k4p6rt7sY2/4
         2Ffg==
X-Forwarded-Encrypted: i=1; AJvYcCXQQR5w8T6kgJ1ab/dMq9f5fWsooM5QDscikI0YeALXw52SrmbjnidkZoqILyVwyUd8i8isYctIpPCHByQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFIf9qr3wxuD+xNHM2z8RPN3PHtcKbNysJX5FHLgq01Yas1n1
	DAKqWXRj9Jy7kM9+k9ozqVXsiJpUhQzneaFQ3JVIW/oxGv/7tzDaCzjr4l7g5Wegc8M=
X-Gm-Gg: ASbGnctN8HK2mrF4O9yL068Lzt7HKZpPn7BUcM5uoTcZv4gHnumJnDzyaBj+5EAq99P
	whV2pkZ7Hpw0T/WMicT1l8obs6+5QlA0Nyywou3RH4TDc5CojNZCKvCX7KGO4k+igzjrfPzAsj3
	rUC7wjCayJA1oscM6UIWi7nbOCwrukQGOrMtSlyVx0YyAq1p8UORIBio0kVyOSGPSRul/DglfmT
	QOggD4hYVX5c7ta+ZT+1LlKG18I1ulFcqz/crbeG4ruNLAjuqPRO9UgGT7RXKnlnsIhHyzp1Sed
	yLDdCvWjadz3HLYqiuk85S4HCrs5dFyQfyilYPovP5WyCQtDy1+x9RItbb7U1wDffYd3NMIne6/
	dW1sevqw9QUmN+QG55EqFaPhHXEvSSEhpPelPREq1CpnQ656jgVnk8w==
X-Google-Smtp-Source: AGHT+IF9oN/gDVZZuBafNymjfs7XlnC1Pfdu0olKj+9cEw7XmHBwFYKpaec3jtfFbtVwLA2vd55SPA==
X-Received: by 2002:a05:6a20:3d8b:b0:240:2234:6860 with SMTP id adf61e73a8af0-240551e9963mr23615243637.32.1755006999905;
        Tue, 12 Aug 2025 06:56:39 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d86f7sm25362441a12.24.2025.08.12.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:56:39 -0700 (PDT)
Date: Tue, 12 Aug 2025 22:56:30 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] rust: io_uring: introduce rust abstraction
 for io-uring cmd
Message-ID: <aJtIDlSBLJSRxBwQ@sidongui-MacBookPro.local>
References: <aJijj4kiMV9yxOrM@sidongui-MacBookPro.local>
 <81C84BD8-D99C-4103-A280-CFC71DF58E3B@collabora.com>
 <aJiwrcq9nz0mUqKh@sidongui-MacBookPro.local>
 <DBZ0O49ME4BF.2JFHBZQVPJ4TK@kernel.org>
 <aJnjYPAqA6vtn9YH@sidongui-MacBookPro.local>
 <8416C381-A654-41D4-A731-323CEDE58BB1@collabora.com>
 <aJoDTDwkoj50eKBX@sidongui-MacBookPro.local>
 <DC0B7TRVRFMY.29LDRJOU3WJY2@kernel.org>
 <aJsxUpWXu6phEMLR@sidongui-MacBookPro.local>
 <9A6E941F-3F40-40C5-A900-4C22B27D1982@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A6E941F-3F40-40C5-A900-4C22B27D1982@collabora.com>

On Tue, Aug 12, 2025 at 09:43:56AM -0300, Daniel Almeida wrote:
> 
> 
> > On 12 Aug 2025, at 09:19, Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > 
> > On Tue, Aug 12, 2025 at 10:34:56AM +0200, Benno Lossin wrote:
> >> On Mon Aug 11, 2025 at 4:50 PM CEST, Sidong Yang wrote:
> >>> On Mon, Aug 11, 2025 at 09:44:22AM -0300, Daniel Almeida wrote:
> >>>>> There is `uring_cmd` callback in `file_operation` at c side. `Pin<&mut IoUringCmd>`
> >>>>> would be create in the callback function. But the callback function could be
> >>>>> called repeatedly with same `io_uring_cmd` instance as far as I know.
> >>>>> 
> >>>>> But in c side, there is initialization step `io_uring_cmd_prep()`.
> >>>>> How about fill zero pdu in `io_uring_cmd_prep()`? And we could assign a byte
> >>>>> as flag in pdu for checking initialized also we should provide 31 bytes except
> >>>>> a byte for the flag.
> >>>>> 
> >>>> 
> >>>> That was a follow-up question of mine. Can´t we enforce zero-initialization
> >>>> in C to get rid of this MaybeUninit? Uninitialized data is just bad in general.
> >>>> 
> >>>> Hopefully this can be done as you've described above, but I don't want to over
> >>>> extend my opinion on something I know nothing about.
> >>> 
> >>> I need to add a commit that initialize pdu in prep step in next version. 
> >>> I'd like to get a comment from io_uring maintainer Jens. Thanks.
> >>> 
> >>> If we could initialize (filling zero) in prep step, How about casting issue?
> >>> Driver still needs to cast array to its private struct in unsafe?
> >> 
> >> We still would have the casting issue.
> >> 
> >> Can't we do the following:
> >> 
> >> * Add a new associated type to `MiscDevice` called `IoUringPdu` that
> >>  has to implement `Default` and have a size of at most 32 bytes.
> >> * make `IoUringCmd` generic
> >> * make `MiscDevice::uring_cmd` take `Pin<&mut IoUringCmd<Self::IoUringPdu>>`
> >> * initialize the private data to be `IoUringPdu::default()` when we
> >>  create the `IoUringCmd` object.
> > 
> > `uring_cmd` could be called multiple times. So we can't initialize
> > in that time. I don't understand that how can we cast [u8; 32] to
> > `IoUringPdu` safely. It seems that casting can't help to use unsafe.
> > I think best way is that just return zerod `&mut [u8; 32]` and
> > each driver implements safe serde logic for its private data. 
> > 
> 
> Again, can´t we use FromBytes for this?

Agreed, we need FromBytes for read_pdu and AsBytes for write_pdu. I'll reference
dma code for next version.

Thanks,
Sidong
> 
> 

