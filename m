Return-Path: <linux-kernel+bounces-880613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AEEC261FE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7FAB351C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C0296159;
	Fri, 31 Oct 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QKXy16eb"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265E232395
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928320; cv=none; b=ZgstxfQnaHhL04Zzcdc1kMnebCdTKEqwEUqS2Zf0ITEtAg01rQzAcrutnE0JreGXCQ4yBR3/AHLQcKhM1tBRL3gQqQDDriKIrBtSwbDDNREaHiGjPBYWJ/ZFjOHYiN7LHEu7/B2q5r5T6dfxkXufHtjrxoL483Wjn5qn0WY6lLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928320; c=relaxed/simple;
	bh=l/IsB7baxIshXUpT/OfHN+vPZ0H1TEj1uw/YI809Nlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFxshAYkeXU2IYzXTw0DUt6ZB36lyFi73kQhc0ltloN91rw2UMl4+jDVT+KxwH3VZcQix0wfo8XoH+TUEKCCCzM5MZRBCmXwPXrxxRY/f0Bcx9afPETon1mhVpXUtbkNbWujL+TEoASF3tuWVlNEFJ+b3kJ4i+GEt2wn2Na4yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QKXy16eb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso674210266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761928316; x=1762533116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTzC3VMhtBJKHk8qqOYuFEBEXEPLqM6jmVq1XA7XYus=;
        b=QKXy16ebPhL/HsRyT7w9NNQgsgCR8XwfhTsJNRmWbo8xe4WPEfKRcune3FVTyjaxhS
         q5ymebnTu79LQgMId4Px6zDN88AzuKv8RiQmk28TjykzoTjEEOnNPV8NAGT4LEUl2ckO
         r1HsfXreIVvfRQEy9D7zeW3y7CjVbX1YK4WUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928316; x=1762533116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTzC3VMhtBJKHk8qqOYuFEBEXEPLqM6jmVq1XA7XYus=;
        b=nLKnv0zojo85sPKk7Gv8iRmrX86qxq/+Kh5h4l4mbJzEy9NZD00IQK3coklcwVyUW5
         T+tfRDpl6ocxnsrz0C/lRuG1nf8QjSpnEZKdnI/MVg0Q/NV6xgDovqA2uz3eh2+Doap9
         OHynU/MXz2ehn4G0DnXQYaRThL6RcEOu7z1yhQni3GBiJXMMwgjwE6esMlfIdP63FHV5
         LkCsvzoHxHk6zoILjWpFvmMP4X+7rPRO7zlhHAoZ/ZnH9NkEc6CbFm6ZgcKk1hYqMKNw
         z26drJoPKtm0P6bWX+OV83jDwa1mC2NCnaydCC+IjBLqHC2Nogu35KS57l04+sL6ZT+y
         J7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPB07600HluI4huc7GdKmUgNvAfBKbIX0N1lrehQ/OXZMclsrIcVuCnXtkvNzk+mjpH9i7nPyY34a/emI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKHkmuf4zohbuE7pnC+0kr1h5NCh/natEZWSpI0IUnPMHa2mA
	JotX9HjxV2zEYKJFaVDmBF7Yxom3pUHkah0bHn6RsjX3DIHnEDlZ+cctbGMLPRI3/H6iesBuyLF
	GC20dH8M=
X-Gm-Gg: ASbGnctYJQXf2TB9K0gE02gDSg4Qx1CrT2U4/RsGqZNybUJsvQCWeJOKUuMlMtA0wj9
	8zi1tkkTl+AERyJ3w/kDr130fRBgaMHUCOlNFEIoARogEDc7ekQ0bObubowgBjm0SuJZxvKauoa
	Vi15d8XcqxvkVSQaDzOzMcgXE0CM/YUM9JAk8+Abv7FDZTPmHCMZS7Mo6U5bxgVqD/YQfN5mh/k
	LW4igfbwZQ+ZHjKHFx7rZr0VbYSW2nOKbTL3jOBKw5AbAYjZplt64jm0NCxMAyTUwCOoxSOfaW7
	S7uxpmCBDV0vGceYrEgGpE8YjsgymLKS/lWGXxmjU18A8CmMlOvBBZVcvPFMSwgfWq0kvEw0cqs
	0adQCXgkt+QN2aZzH7P26a804rx60C8zEgQv402pZ8W9SzPOrIZdbvJ4dA8cCyR5F9alz68cFsG
	oN4L2Iy67ZjH40sfmPIue7NpV0P/tvSuDPrpdnDXCmHwDTCLxf/A==
X-Google-Smtp-Source: AGHT+IHm4cKl8BuwNL+2cKIr1MRrz2YfFJqSBLbddrU62fexvdTpurDXuTgsZH4Ul4p/1zpRSVdkog==
X-Received: by 2002:a17:906:fe05:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b706e242bb4mr467524066b.5.1761928316525;
        Fri, 31 Oct 2025 09:31:56 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077ce9184sm215982566b.64.2025.10.31.09.31.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:31:55 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so1588139a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:31:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrvtjxd8GgAESTtv0HId37OY7++Xer4eQNLnvnhDyLebERdBRfqzFfE9an3Ddgnr/qrXDtuOTfgH0Virk=@vger.kernel.org
X-Received: by 2002:aa7:dcd4:0:b0:640:69fe:5ec2 with SMTP id
 4fb4d7f45d1cf-64069fe5f23mr4631406a12.6.1761928314897; Fri, 31 Oct 2025
 09:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
 <20251031-liehen-weltoffen-cddb6394cc14@brauner> <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
 <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com> <CAGudoHFC9vfHZsgjvib=Hy8wNom27wYG+iJz=5G_6zNQHF2ndA@mail.gmail.com>
In-Reply-To: <CAGudoHFC9vfHZsgjvib=Hy8wNom27wYG+iJz=5G_6zNQHF2ndA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 09:31:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
X-Gm-Features: AWmQ_bk0Uo4HxrcVgEGKt9-nJllcNUr5ayxKLvAURW3YE6knhWkqfLYOztYPiIs
Message-ID: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 09:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I take the intent would be still to fail compilation if
> runtime-const.h is included. The file is there for the premier
> platforms, but most platforms still resort to
> asm-generic/runtime-const.h. I think it would be beneficial to have
> that sucker also cause compilation failure if included for a module.

Good point.  Yeah, I think you're right.

             Linus

