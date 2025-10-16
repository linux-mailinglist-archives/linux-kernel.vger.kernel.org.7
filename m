Return-Path: <linux-kernel+bounces-855778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A4BE24A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 187EA4E12A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB63081CF;
	Thu, 16 Oct 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHmZwVQz"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B42DC760
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605631; cv=none; b=ognSET/W0YzJhzhQG+95v4rYsBe45497YmzSBwu+KJy/nLoDerGuw1Q14M7N3aCmW5espev3a8VpvPoIg6RQ/4o9aLVf5XzPXB+lIJIqp7oqfy7V6J/RmyrZMCxK0B4QE/42JowVnkl7Q6yw37mx5KrOoCRM9qi6tnB70Bjyqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605631; c=relaxed/simple;
	bh=guwRIMi0wiANNJuAD6tIEMgIhoRZw5vVBX6qb9J5PBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xkh0B0SnMgXqH/OgnpJxVqWC3DHkyTZW3b1zfbRiqJQmY/M3QkbFZcrGo9AcU6Zzu5UC9tgcf7q9JaUlJxK+HWFgWjgvkx1i15athftBlWLkzQFyW6HQ7huUd6QJmhYl+qiuT2RoZ8eXWa4gsmHKMIhP6pZ859V0uQy9JUCLvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHmZwVQz; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-633be3be1e6so746959d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605628; x=1761210428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=guwRIMi0wiANNJuAD6tIEMgIhoRZw5vVBX6qb9J5PBk=;
        b=WHmZwVQz6RljL7QN74Hm7itsTO+MvpEcatSH5KAdIvbjXhb08suymboZEQkDBOlBmm
         8xV/jY66p5h9S5AgUgg1/DDUwIixBvrMLRadvOLX427Pu9ce0nVMyvl0W07+rVcgqjxv
         GYBQBwoEGYxK5XdKhD4G1X8ocAv7n9GyfpGiZKDeQfXHln7plmO/+A1FbXSVtrVpUMzk
         +O5nhWPSHJBEafEiQiHRXB7h6B0J11Jg3T/BL7V2KbaHYdgdbfFG8LTnsPVQlM9hJVa/
         m6asT+qpNtJvtp7LpG7d0NCf6S8BfKMWhREqhWW5inZ5V5s8G8UoRc9sMxlMBVgwHSEh
         ggYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605628; x=1761210428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guwRIMi0wiANNJuAD6tIEMgIhoRZw5vVBX6qb9J5PBk=;
        b=fH6sava4KYMQPkHq3seWIFMkcnX3Dg/LQLcI1pY/uzre9r7VtyYW4kjBx5GO8eLfZ0
         itp9ftdHIsWL6p5r7hmTY+5mcFAz8v5rsyV1D7ODELxBvBc+Sjlp9VgV4bx7vJ89EZE5
         oG6+hpyegrZPnVi2XuPosZdCrMTi9G7hESH9gTm05DBvQhQBCgbAy3QStonnd8GrCCzM
         v5ZskmWdbewwRHL3ACPn7yd4mhe3yFyp7a3oV71QroNwb+OynOAzhaDylxAZnEdN+o4I
         8FqK2Iq92WW+uuvVcJPRlljYC/+wR/SHFaeEj5XWQ/ZvrHfQyO+6iJKx9CPXv5j37OYG
         QZpw==
X-Forwarded-Encrypted: i=1; AJvYcCUTuVzqwR54dnB5rGyqZblocVtZ/tu62+nDI9+oC8yi10bDDVRpedHFE2GCO4tIKkxw1ye+VxvoII//qsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTbZo7pvgTY5dH9ejHN93On3/6q1QLqPF1fCVtZ0KMElpUCSb
	38Ms9sU2fb2j0Zeo7cxpZqbcQhkeCp7TKOwM2hTHKuo1aXyM16t3FTtcu9LKPDJhtuAILPnehBo
	eCShptlQoAnBsttcJ1fwDU/0429M7k0Y=
X-Gm-Gg: ASbGncvtf+hWFfDZECK9PrC+1iQme12vlO4NRRs4o2zKbKLzoFxJlJeC0m4cVYSrQmI
	AtasjnHXwhG5Bi+jrXEh1Pni6P9mM4lIIjSi+cwrXc0rLkNMqHM0baXba4y/v/8gnZxEWNU8yxo
	nxY4Z35E7hrObNB8q59DqWdVtQSiEdWXnl+tm5gFa8bzGFR5qSbj754OF5hLM9XKGiK+DEHPfav
	xgtlTAhdLvtEz6pfYBowHblssfJ19qSs91pR9U4pRAKTGR8sQmj8UZLG66kUg==
X-Google-Smtp-Source: AGHT+IHVbO3++jsGwWmg/F2c4ksP+FLckoJYfOSeFWsAVaD7OsNLADoUPFrIAhLYYE/gNFYYmMmLiTqCkuWEcxtPEn0=
X-Received: by 2002:a05:690e:4012:b0:62f:ce58:62ed with SMTP id
 956f58d0204a3-63e08fd5985mr2306140d50.18.1760605627783; Thu, 16 Oct 2025
 02:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925200625.573902-1-tmaimon77@gmail.com> <175890301752.880349.2331946518360447485.robh@kernel.org>
 <CAP6Zq1jmmhqYu3C7KHFK2tz9zjW352Bbw4cXeOYSjNSTELrp5Q@mail.gmail.com> <045c7bcd3a852e626f11e5b78c07939feac0e298.camel@codeconstruct.com.au>
In-Reply-To: <045c7bcd3a852e626f11e5b78c07939feac0e298.camel@codeconstruct.com.au>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 16 Oct 2025 12:06:56 +0300
X-Gm-Features: AS18NWD2PDfZcVJRgxIyX7bEOze1mHnCXeX6pVqo7IZ1SuA6mem-A5kplcE6yyY
Message-ID: <CAP6Zq1h6u0t8D4sDifGjVw6M_cTKxurxiPiO8yxFW5HtJBRvPA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm64: dts: nuvoton: add NPCM845 SoC and EVB support
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venture@google.com, yuenn@google.com, 
	openbmc@lists.ozlabs.org, benjaminfair@google.com, joel@jms.id.au, 
	krzk+dt@kernel.org, tali.perry1@gmail.com, conor+dt@kernel.org, 
	avifishman70@gmail.com
Content-Type: text/plain; charset="UTF-8"

Sure, thanks Andrew

On Wed, 1 Oct 2025 at 05:35, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2025-09-29 at 12:15 +0300, Tomer Maimon wrote:
> > Hi Rob,
> >
> > Thanks for your comments
> >
> > Most of the warnings occur because the compatible strings are located
> > in .txt device tree binding rather than in the .yaml file.
> >
> > The only change that needs to be done is in ti,tmp100 that
> >
> > Could you approve the patches, avoiding NPCM845 compatible warnings?
> > Meanwhile, I will work on converting the txt to yaml
>
> I think it's best we get the conversion done, and then subsequently
> apply the apply this series. See:
>
> https://docs.kernel.org/process/maintainer-soc.html#validating-devicetree-files
>
> and
>
> https://docs.kernel.org/process/maintainer-soc-clean-dts.html#strict-dts-dt-schema-and-dtc-compliance
>
> Andrew

