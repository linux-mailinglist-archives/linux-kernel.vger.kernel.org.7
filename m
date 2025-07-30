Return-Path: <linux-kernel+bounces-751140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED2B165A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A418C3BD023
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A02E03FA;
	Wed, 30 Jul 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyQjebJ0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC2347DD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897211; cv=none; b=EutTLwtpa91Qxrvq7TlB80TPF8kk/1k6JX5mCJXj/ULRAwnLqeBZDC0VDBLijfRGWGXuEd8gSezWDdwo8lA5a5ZbRC80OzMp/naJ0OnBfuxWp93muMb6VM8u6hi4NThYMkjHiLWavQCEy3FVCZ4xIHVwxmNhZVQQwChHsPFZtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897211; c=relaxed/simple;
	bh=VD3wo5oaAPAR9nPCr71XUfOSWEbeYPL4kR5lp7XczKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsBg7pw7reX8I7W1hHF0xDn+jhDDKzQOyYZYrnPf7nr60tUQ+/H5ODKA7JtThGoikoMVHjicmcl6Q2VMRfkSnusXehLNuQ9d7kVcRLILMJpPnHZAkeUqH/VuNt5DQbRSvcjlLcmNVNTOvQjgzgFGKnK/KS0SugZKf1W4yyLxiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FyQjebJ0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso47559b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753897204; x=1754502004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmS6bVYq3PqzYjaFJqOEs6GoaJfi+gAn12+ufIU/vGg=;
        b=FyQjebJ0nv5yxHIuYza1MvOHxTB5rG5AoLXCwU3Nda3+/Le6/Yz34C4qrhPK86KHKn
         M12dY/IIibsvfb/VSP7cNz20J+FhO3x436QACAMyG2pGV5a92iyJPOZEvsig2r5+0QhZ
         JJ+vNLr7sNLVkj6HyNFE0dxD9L47TUkhhY8ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753897204; x=1754502004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmS6bVYq3PqzYjaFJqOEs6GoaJfi+gAn12+ufIU/vGg=;
        b=J25Hr+xxfUTBZTXBRMYoRp74Qx20nBvfcdvNC0v/8CkfZMS8vDTgEcfGf5r6/xwuQ8
         k6qeC9ovp+Yiqzk1Nwji2oxc3WiW6oMdBZHgB2Pol3d+BpBz7HdwPq4IAZPUDRt7fqRR
         Rrbe6hw9WrtbUJ5d1CZlTljMIPAxf3+9w0zA1x2m1jtupUo2aOQEklOTjnU2Wcpja7vr
         RU4G66b+tiBePSZ36sxKNXop3TmZm08zq1WkDvdw26WKQLoztUjC0Zq6MxAm4ktBkqnp
         EeLIgPW1UjTbzEFfj9tscZz9BA1LBKcFERGp+JU4ovT5Eyl8sdoquW0QvrO2Y0Zql9rx
         L9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQT9hAlMLi6KkWcGbchE2jrwJ2iiLznh0cHBGQ4I2GmBvwui4QhiMnkn2v+MyOKjpAcUWWZIkwSvXeIfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+h4Q5ExXFqsxYVRS3Gvto4XGsTeE1lEI7JRiDabzS1IrMr6p
	LEz5+GwuIBhO7Bgive5WMs2p0PIW3zVuF2QxG4QpaFfpKIuNsT92eulqBZ49ZA01pTzxjBm9p5n
	7wmA=
X-Gm-Gg: ASbGncslRp/dPPZe4UVkeQY8UBY0qBuLkbHaH1rE+dy9KypAMfh4mgPUZNxbHzSE0x0
	v6iG4+QBdVrsMKIz82iHGzfZsLp+da1BAVg8xX0W1BC26JjpZsxljcCm0X/krq3kJhR3767evWB
	iTsNkg1/bcN8lUqzDvSLDOLpNsnzIdxJU091sMWeH/ravzIYxpoHMY/QeNYHwOB2dBWS4lZLi7L
	mb5E8vma946ZO9Dg8CIsVP1/te96uNih0UAwXWvlUiNL3YNZ20c22eiJLWOQV389EIcXRJGFnMz
	MA+ml5Vl8O3nx8VU/fcH/Na2lnrQxzSWOa6H+SNZdJhtvTU/FFqwIOZwWUI49+A2RQccbjLkK3p
	VHAU7vRzM6WPKIPn4ZPGJ+yu2sGt0f9CSdKsoTiwSaTAaCAe5OpAuHy124jLorw==
X-Google-Smtp-Source: AGHT+IFSAegIcdq3zNu8Hl3JRR17gESkUSdXisoE45MHXRoFjLvVD2zpcdXOzDHSrqhGxn3YZRdyCw==
X-Received: by 2002:a05:6a00:7082:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-76ab32f4c0emr5304096b3a.22.1753897203863;
        Wed, 30 Jul 2025 10:40:03 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a53dsm11260165b3a.1.2025.07.30.10.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 10:40:02 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31effad130bso111868a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcpaay3Etite7F1iolJ/Xzu/shWhIss+mpPt7soENfHBsg8vmrpvYABs3dzaj+LMg5MhR/SjGYWpM0UJo=@vger.kernel.org
X-Received: by 2002:a17:90b:33d2:b0:31e:c8fc:e630 with SMTP id
 98e67ed59e1d1-31f5de73bf9mr5384683a91.26.1753897201409; Wed, 30 Jul 2025
 10:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730071629.495840-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20250730071629.495840-1-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Jul 2025 10:39:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XThBbAwQcuR8Po6KfR0LwsfwR0HCr7j0Pk57n5XeQu9g@mail.gmail.com>
X-Gm-Features: Ac12FXxQZr0-8IcS7sB8WEKDBJN3gQrS50vttC8EXroWdTPe0EPqDAF2tpw__8E
Message-ID: <CAD=FV=XThBbAwQcuR8Po6KfR0LwsfwR0HCr7j0Pk57n5XeQu9g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add several generic edp panels
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, treapking@chromium.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 30, 2025 at 12:16=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Add a few generic edp panels used by mt8189 chromebooks, most of them use
> the same general timing. For CMN-N116BCA-EAK, the enable timing should be
> 200ms. For TMA-TL140VDMS03-01, the enable timing should be 80ms and the
> disable timing should be 100ms.
>
> 1. AUO B122UAN01.0
> 2. AUO B116XAK02.0
> 3. AUO B140UAN08.5
> 4. AUO B140UAX01.2
> 5. BOE NV116WHM-N4B
> 6. BOE NV116WHM-T01
> 7. CMN N122JCA-ENK
> 8. CMN N140JCA-ELP
> 9. CMN N116BCA-EAK
> 10. CSW MNE007QS5-2
> 11. SCW MNE007QB2-2

nit: CSW, not SCW.


> 12. TMA TM140VDXP01-04
> 13. TMA TL140VDMS03-01
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Please make the subject line a little less generic so we can tell one
change for the next. If all changes just say "add more panels" then
when cherry-picking and looking at patch subject lines it's hard to
tell which patches have been picked and which haven't.

In this case you could mention that the panels are used by mt8180
Chromebooks, like:

drm/panel-edp: Add edp panels used by mt8180 Chromebooks

Also: even though it's a bit of a pain, can you please include the
EDIDs in your commit message? I know there are 13 panels and that can
make a long commit message, but I'd still rather see it here just in
case we have to later go back and reference exactly what panel you
were working with in case some manufacturer re-uses panel IDs (it's
happened in the past).


> @@ -1865,6 +1880,7 @@ static const struct panel_delay delay_200_500_e50_d=
100 =3D {
>   * Sort first by vendor, then by product ID.
>   */
>  static const struct edp_panel_entry edp_panels[] =3D {
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122U=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116X=
TN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120X=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unkno=
wn"),
> @@ -1883,6 +1899,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B1=
16XAK01.0",
>                          &auo_b116xa3_mode),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unkno=
wn"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x52b0, &delay_200_500_e80_d50, "B=
116XAK02.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133U=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116X=
AN06.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116X=
AN06.3"),
> @@ -1890,10 +1907,12 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140X=
TN07.2"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116X=
TN02.3"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133U=
AN01.0"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x8bba, &delay_200_500_e80_d50, "B=
140UAN08.5"),

All the old AUX panels seem to use just "e50" but all the new ones
you're adding use "e80_d50". That looks really suspicious. Are you
sure that these new panels need "e80_d50"? Were the old definitions
wrong?

