Return-Path: <linux-kernel+bounces-805129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B585BB48455
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA617DD1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D851C54AF;
	Mon,  8 Sep 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Shk3aR7M"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE342367D3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313687; cv=none; b=X4ZIBDfFcyJLE2mz+ZQd495kNKEKd+O1Qv5Yf0CqlcBnv53s5wucZ6CJQPvagES5pWeHqOMSYleUGLhcql6E4Qpaghn+gjEt2+Yd7GVT+9nhgNEragoZK9u5lC41WUczUkTqSvVPs9tw+Zc6TtnOBNVuD2p/y/MnV9MvOJqUjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313687; c=relaxed/simple;
	bh=6H45YsEdRX3I7ROlKXYkzKQEqvNZooFomH3XBox0HX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hipQXj/ObBoqCJWJhLCiWM8+jK/ZV2BTUYw9BwGncN0F8PPTDS7mr1mdGrehoEXy6vxjFLjgRIDk/+j5mT2Q1RGWZAqq4P3gCDW4aEIQ14LEkRbho3kmDbHIf88++IX9ULHE3GSY3XLAn68zRaAHtSM6RPMh5h8q4mQAcM0vE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Shk3aR7M; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dde353b47so5359475e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757313684; x=1757918484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkXagCl/AYgtldzrQyVYMLNKfsSUwxilFSVrqkOB0fg=;
        b=Shk3aR7MmeYDgTYBQertb8bsGShVlBaB3zjHjx8wL6K0a0oUO9GjP3fy5GdUpxoZbh
         JjlN+k2JaoFSt5lW1t5KbO7bWYT44oamUJe5LcL1eeO7JgRdJ0hMwcayWI0p0aZ1JHTP
         MnhUUN4B5r8U1ydk6XmMUhREV6lP5eXhP1gXW8WaY2Fk6EAMTiwRLmeGdWG/voppVkwi
         ZbmgWyn1A5T3QBCer19eGMVxC3zG5THJHZYhVeO78QV81vXggY1ILK114bQTETw6BmD4
         w5kRbhCONQLNQNwZ7EsaB6pfrpxQbbQ40xCHsWnTQsacMMsMlBS7/ZXxgw8tTQkOxtam
         pNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757313684; x=1757918484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkXagCl/AYgtldzrQyVYMLNKfsSUwxilFSVrqkOB0fg=;
        b=sqRMZKIOv4lyGxZcFJr59r47IQmfU/Q2pd8aejiNS7R6ZQxrR76whiP3ViB86WHQq0
         XvI0IIXhh9tYaNdHN4doSiGaHNccsSM0PSEcWowzp+S07kKHvfM5Ap1jPiqv1vw5b8i2
         I1n2wGH1VPBHAhU2IndfKVWimcMCyloUdLNJDG1zOWN9mu5A1Ij2RpyalLzQ8kvskaXt
         P+Xrsdb1Ql9xLiaftmjITx6aKWqDB3Jtaxt7tO+Wc9NkiyTxHBIIKzvfI+MUT085AjMq
         OdJ3N6QGzjozxMWGhD/4CrJzqHlpI5tOG1VQXqpgnkQqn8HatNy8++6APf/KLVqjCRag
         /YMg==
X-Forwarded-Encrypted: i=1; AJvYcCV0OANMypGGedOm3k0pu4rBVox04QjHYfdNasvrbe9h4hZTcfrcASJOkN2gbgKSKhZvoXy4AyqdSr+HGQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMX+YMXL0Wvx6yYyTwcKWzNnxmhygRG3O1LF87B7i1nCZDkvA0
	etcGCHnQNQ6lrUIZ8ysdJkHeUOQQydmHfI7ap54T9yjKsBfW6n5RRgHXjOhtG+4p1Jq8GDqidNF
	z9NZAdQ+XXPTeDSH7wXbcwb/Fm03exbcBqIe4FjjGXg==
X-Gm-Gg: ASbGncvBIM7KN1/6BuN7Q0AM0R6b7CrLo1ZTLG7SnPRhKX8BpXvNh2ro2EklHX5eB1P
	5IKwKjs2GKnMW0tUheNbIuSNAle73mFwoF6sQOMmcH1Sm2dFzTBmXQRzlupXaZxgoejp2ZVEbIO
	5LbhduBvK6hhJTcShWXewuCW1lrjH2qzUMTut46ieVbtxvtplPprBoQpkaHsMYjtGGbUYFuLwzy
	gvl0d8=
X-Google-Smtp-Source: AGHT+IHfg86okQAaqA2qPatL5ihHv5DDUErenS6tECvB2YYrt6RqWL76iuGx0WtCqAU2MP1oam8FMCdRi+ULTYTtuSg=
X-Received: by 2002:a05:600c:840f:b0:45b:6365:794e with SMTP id
 5b1f17b1804b1-45dddecdacemr60624255e9.24.1757313683943; Sun, 07 Sep 2025
 23:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905075114.1351267-1-wuzhongtian@huaqin.corp-partner.google.com>
 <CAD=FV=WZAXnTGHhrMHTu3p0GL2ky2W1Xqmw2x2cL6FvvdYgG1g@mail.gmail.com>
In-Reply-To: <CAD=FV=WZAXnTGHhrMHTu3p0GL2ky2W1Xqmw2x2cL6FvvdYgG1g@mail.gmail.com>
From: zhongtian wu <wuzhongtian@huaqin.corp-partner.google.com>
Date: Mon, 8 Sep 2025 14:41:12 +0800
X-Gm-Features: AS18NWBVVIYARbo9jGChFGToa9tLqcqLCFn_Os-0iwAz9fvFKHyHFp6ByrImigM
Message-ID: <CAJUL2LOwJd3t2oEZwx5Q5iZhg4DDtnqAcb82bvmxotKNonO6yA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add edp panels used by mt8189 chromebooks
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for you review.

I have update patch v3:
https://lore.kernel.org/all/20250908063732.764289-1-wuzhongtian@huaqin.corp=
-partner.google.com/


On Sat, Sep 6, 2025 at 12:41=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Sep 5, 2025 at 12:51=E2=80=AFAM Zhongtian Wu
> <wuzhongtian@huaqin.corp-partner.google.com> wrote:
> >
> > Add a few generic edp panels used by mt8189 chromebooks. For
> > BOE-NV140WUM-N44 V8.2 , the enable timing required 80ms. For
> > CSW-MNE007QB3-1, the hpd_absent timing rquired 80ms, the enable timing
> > required 50ms, the disable timing required 50ms. For CSW-MNE007QS3-6,
> > the enable timing required 50ms. For CMN-N140JCA-ELK, the enable timing
> > required 80ms and disable timing required 50ms.
>
> What makes this patch v2? I don't remember seeing a v1.
>
> Also: this has the _exact_ same subject as a patch that already
> landed. Please try to make patch subjects at least somewhat unique,
> even if it's "drm/panel-edp: Add 4 more panels needed by mt8189
> Chromebooks"
>
>
> > @@ -1949,6 +1956,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT=
116WHM-N44"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV1=
16WHM-A4D"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE1=
40WUM-N6S"),
> > +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a6a, &delay_200_500_e80, "NV1=
40WUM-N44 V8.2"),
>
> Please sort properly. 0x0a6a definitely doesn't come after 0x0d73.
>
> Also, from the EDID I see:
>
> ASCII string: NV140WUM-N44
>
> ...it's better to use this exact string and get rid of the "V 8.2" at the=
 end.
>
>
> > @@ -1978,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, =
"N140BGA-EA4"),
> >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, =
"N140HGA-EA1"),
> >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, =
"N160JCE-ELL"),
> > +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, =
"N140JCA-ELK"),
>
> Please sort properly.
>
>
> > @@ -1987,6 +1996,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB=
601LS1-4"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE=
007QS3-7"),
> >         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200=
, "MNE007QS3-8"),
> > +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "=
MNE007QB3-1"),
> > +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE=
007QS3-6"),
>
> Please sort properly.
>
> -Doug

