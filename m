Return-Path: <linux-kernel+bounces-823106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9824B85831
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6806162CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E830F7E7;
	Thu, 18 Sep 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEj4rZ0A"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FD27AC4C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208564; cv=none; b=Uk6r6IMeHgRn714vNNdJuZsJWIXupHPteVZXk1O+aGiuEZywTLZ6KtUjDlUdVmb5MBeLQ3CDBqfh3IdH3PDDKpz+tm/pGWWntnCpxTdhNkoY6THNvZZe/7k2nLIAAKHkaOohW9pwAW21j4j6+A0mj7yBfyuPvC/ZfPbgsM3kw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208564; c=relaxed/simple;
	bh=ba1MwCUdfJFXcSWZiNzRoEiVzaEaDWkPBHTa1hTJBYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfzQyGR6BMtqedDyx4GRB9PoxKj6noPMMrs6Kle5Jxcdgxqn2mm2bxiRHDJ8lQIp5FFa2XSyo1frtntXNP4aLVqcOpAouJhZbmyjWmqLo9w+5K36wWHgmzeRGPUIWX/If+BViHA5dNcM72dwOYKW5NzZiRPSkPiwkfBtAaXTP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEj4rZ0A; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso727414f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758208561; x=1758813361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba1MwCUdfJFXcSWZiNzRoEiVzaEaDWkPBHTa1hTJBYo=;
        b=LEj4rZ0AMMHZtyZb7j4NI80UbI8Hm2EJxa6ttVE3ctMkO3eWqr+UnWSfQ4nqP8XhTO
         42D5/rYI0zMcEVxNEbjxIhoq88cAPlFxbq2FFEc4clsh3lnBuF7hCjMxw/OjfOp5MOGG
         sy0gU9Q49I6bAOddDS7wA/sdZkQ6Jj7lkCrOAJUqo989hOP35bt1/tPKP2+92M3aQ34q
         JF8ByXlJxriHb97XqqGZ/hul1kc4yFpET1osP5BfKywGldDAKQqisDEjTtlHOCYhP/4C
         SmyfCmcXOUcmCg2OXNL8aCa+bug7BBreQjv5V8mQnBAup322sp6W+gnqCrK85uL/HXZP
         ce2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208561; x=1758813361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba1MwCUdfJFXcSWZiNzRoEiVzaEaDWkPBHTa1hTJBYo=;
        b=rk7Z8IxPZgKNnPRUBXyHSogdSWZ4R5TopJfT58TGsNub/XAFGHu9hrfYyhyxajbnKz
         V6e7lkbuOYQPEDo9yYOcZ/jz4nlWBBY9b410d1U0ZL2855kc2PSA8CPSebBkJWMKl+Lc
         5HToVfUim/f8kDIzG2UCjUN4VhNcqax72TXFqeueiZ8XrvbzWAsINHCd1be8uKg3oWTs
         RhCKXJFqbrEqxTyNTsDBPvHfT7GPFeaeqz89HHuYsC2g5itzk+s27pdeNpR1Z2Hp66DY
         Nh8sd5yrK9stkDml+opZ70cLQVm/eYyWzZzPt6p4gQLTCkEmw3U/5KmwtY+FN7YnenG4
         Xq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMqqBEG7zzvao0TQt4QEmkQamXi1ck32q/1BDbh3KcFL/eUa7ztN0mr1R8DOhsBRziFyyl5dn19g/12mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54BVgAoyD3IEK0X7uMcvrFYYsjb8Vx33kRTiqyqYlph8aNHyg
	jqCK34DM48Pr4I5WDdb5OD04U5qWRTu5D8CJIQDRbMnTdce446sNnc60hSyk0ga2qvPWMH1mStV
	FOE9m5zFxFXeMnk7gfK4xNsLxXIipOosKORbAW9S2
X-Gm-Gg: ASbGnctHSVMHA7tdOyKcNd0GEhJnq/+HZmeuLKPLVIMs6HZKInzrcA4vSJqoa81iImi
	1iVMJmKAVYeE8rBOJbcgeQnK/sn2SoG07GgIGQ16HwytpotVpfPHyQ6Tt3YRQm/96eXf9H4zu9j
	2/pp1HPf0+TTD3WzY3RU8bmi5cXwpK1+qcRwEv/o9E06kxP4+8SI3ZlO5JM3kGlIimhknLpfcJO
	XufUC5KfhthvpqFMbjTVgvbK5xEGwyVPKvamXDxH0CYhdhXbb852HllUCwZpazr
X-Google-Smtp-Source: AGHT+IFQAhGQVrc0ungSn0zq3CpjAET1I/cC3NgM5eoz7k2nl0+IyeFHuw/NaM/RjH1vzdmZSNxriNGDHHlStXtyh7I=
X-Received: by 2002:a05:6000:2885:b0:3e9:2189:c2c3 with SMTP id
 ffacd0b85a97d-3ecdfa4049amr5630267f8f.33.1758208561113; Thu, 18 Sep 2025
 08:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918144356.28585-1-manerakai@protonmail.com> <20250918144356.28585-3-manerakai@protonmail.com>
In-Reply-To: <20250918144356.28585-3-manerakai@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Sep 2025 17:15:48 +0200
X-Gm-Features: AS18NWDwxi2HM3ygSiKAYEcBCiKuhDKgr7oLvleUFCAaPsKX8Qf_0T36Xy0wwtE
Message-ID: <CAH5fLgiDJbtqYHJFmt-2HNpDVENAvm+Cu82pTuuhUvgScgM0iw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
To: ManeraKai <manerakai@protonmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:45=E2=80=AFPM ManeraKai <manerakai@protonmail.com=
> wrote:
>
> Added the general declaration in `FileOperations`. And implemented the
> safe wrapping for misc.
>
> Note: Renamed some raw pointer variables to `raw_<name>`. I'm not sure
> this way of naming is good or not. I would like your opinion.
>
> Signed-off-by: ManeraKai <manerakai@protonmail.com>

We already merged read_iter / write_iter functions for miscdevice this cycl=
e.

Alice

