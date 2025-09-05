Return-Path: <linux-kernel+bounces-803381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF4B45E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08BFA06C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18962306B32;
	Fri,  5 Sep 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dq9Rz8wS"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D051D86FF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090504; cv=none; b=VLE01APwVN+AbB1PT37yLrAgyf7gL8Sp1MD5L6fdcNTqlDv+nYi8J1Y5H9QyvEtcr1cRLB8ZW6+Ip0FV7VIeRZOGHgv3U5oGix+Gr7WXelU1mb3CPVmh6FhoXBj056TO2Hq4EbKLTT23c9DnEa8UkJCUqPlmX2hKYUVeriFSieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090504; c=relaxed/simple;
	bh=0286AYSUBDl4S/fF6H9DXJIvoFgxnfEnIVf51/iuznQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K034Q5XqdizwkyvrIqq/LZsaM87B6TqOIakpMfHcI3+n5qCEa92en47XrIcmcidiBQ4rIAJNn6D1MwGNwISRPzDIcmfC7jfdnwpWmnKbAo1kdMahJRWxaZXh9dKzXKIJtPwzGqKVw8263r7BYPybzRc0xA4MLf77XslBdyUAjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dq9Rz8wS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7742adc1f25so152521b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757090501; x=1757695301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7we2w26uCtv2wyLrEnRWoDa7Ong3sxHBpOuF+Z3zJ8A=;
        b=Dq9Rz8wSX6G0nf7JWRuHMG+IBIE9a7KN9rkJjjTdB/UhBdjH3pokLb2mlLoGHAS4XW
         A1o5QYHLvxMWJdf2uzMkH7kgWmmqqO2zFmfEg+l6f1DXFpkksYTjh2HqzlPoVL9YrWJP
         FBm9J7AsRggPrgAcrQwP2FUerIGmsjkDQoyfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090501; x=1757695301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7we2w26uCtv2wyLrEnRWoDa7Ong3sxHBpOuF+Z3zJ8A=;
        b=MJ2HtEryPfjXoIIZq5ynaiMqqHcmMLDdsb2OkVHLFhx3n5iNK2LQ1rDltRYjwKQE0Y
         WZV0lu2SYpSjrX2fx0QGx2RHphdWrBagiFEcuRQQeGJXNHgotxS8mRRkQ/91uP13bLeI
         QPeLssl4Y0y1RTncU1T6Zv2Kg9S4tSarMeV7YCLk2j8zSxymTeb+atspK09lmp3WJeh+
         ccIIspmoMHTlGHM73rhapk1P42ZL3eVDfXx29NWcJO8bA0lKAb0cjvNaoz0ipZW1SsYa
         EbYUr1K9qGqDK5bvGjsxh7tpnuS07yFx8ZP3wQSPVFZYRKHOMhA8WcoZOL+MPr2RaGtx
         JIrw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1K1uCc+UDCPBJ2Wp2S8yTqkBMOqTPK1bTq8JA6lp/zb/q4i3kWg6NcYAoJ9f97vABQ5Cu01UPM39O+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtwyI7qJcJUoLJk2YmAShar2CRBuMkHJbr1nwxo1GIwCYLkwu
	+NN4xKJLLHwRaP2fKTmMw5H29VD8Z3KHN8cmcpSse/H2uuC7240SWeS4/xmDJqxhKLXWISn/W0O
	9C6I=
X-Gm-Gg: ASbGncvMQBtT8oDX85nBMMRzKOByMePE2THyuNIou8F7Q3QSh4T3Wp4Q0r4P+hs32aR
	QQ17w3AHPrld1IUp+EUPIuVz+sdL3Q5pZMvC60bWg5VinNFdwn542vg1Z2KqkKhcnSSkXsd7lu8
	Fsh0oKOjncl7M83TVzK/6/gczrHyMXnCU7rcJOLp1hDQLYCzEDCo2B518aZMJ7NMrtBL8j0BNd1
	3KdLTrYa4nbCKYNewhGMl2WPmEJd7kkBqgNmOTlARHhitbyM4ne5E61YV0N98kwIjBIuH16lPr3
	4qEMr1KeOXRZXSFEcib8T1BEsQ8Db8dP6oXdMSPIpwqdscfIfOuVFbgccAFAX030iDj8JUih2Fk
	PG4tHSg5iDChXSaAMbdCOuydgjuDAYcAOE8tNH016QWqIsrPgSxC2G5QWKPLJjknqax07eMmmhU
	Rj
X-Google-Smtp-Source: AGHT+IHIRaQGmq/paQssS3mo2f4Wp35D8nFeTgKwCjaJdYJNUf5tLW9n2mgzXGwv1fRD21V5Vrx8oA==
X-Received: by 2002:a05:6a21:9986:b0:249:467e:ba57 with SMTP id adf61e73a8af0-249467ebcbdmr13644786637.24.1757090501341;
        Fri, 05 Sep 2025 09:41:41 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm19046692a12.13.2025.09.05.09.41.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:41:38 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24c89867a17so23449905ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:41:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxgVPyp4/9jSGcJ4UAYVrCB6NsNOlrTMZrxaRNzCexy+nnHk57IRxC8BhQK3VSpDzBhUpw/aA5+X39WTw=@vger.kernel.org
X-Received: by 2002:a17:903:1b06:b0:234:9656:7db9 with SMTP id
 d9443c01a7336-24944aa33a5mr259852875ad.32.1757090497817; Fri, 05 Sep 2025
 09:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905075114.1351267-1-wuzhongtian@huaqin.corp-partner.google.com>
In-Reply-To: <20250905075114.1351267-1-wuzhongtian@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Sep 2025 09:41:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WZAXnTGHhrMHTu3p0GL2ky2W1Xqmw2x2cL6FvvdYgG1g@mail.gmail.com>
X-Gm-Features: Ac12FXw2uXvSstxlAtnEXB_V9QzuCq1FCyLEPvienl_1abNVtyIr3AkvXSP36pY
Message-ID: <CAD=FV=WZAXnTGHhrMHTu3p0GL2ky2W1Xqmw2x2cL6FvvdYgG1g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add edp panels used by mt8189 chromebooks
To: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 5, 2025 at 12:51=E2=80=AFAM Zhongtian Wu
<wuzhongtian@huaqin.corp-partner.google.com> wrote:
>
> Add a few generic edp panels used by mt8189 chromebooks. For
> BOE-NV140WUM-N44 V8.2 , the enable timing required 80ms. For
> CSW-MNE007QB3-1, the hpd_absent timing rquired 80ms, the enable timing
> required 50ms, the disable timing required 50ms. For CSW-MNE007QS3-6,
> the enable timing required 50ms. For CMN-N140JCA-ELK, the enable timing
> required 80ms and disable timing required 50ms.

What makes this patch v2? I don't remember seeing a v1.

Also: this has the _exact_ same subject as a patch that already
landed. Please try to make patch subjects at least somewhat unique,
even if it's "drm/panel-edp: Add 4 more panels needed by mt8189
Chromebooks"


> @@ -1949,6 +1956,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT11=
6WHM-N44"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116=
WHM-A4D"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140=
WUM-N6S"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a6a, &delay_200_500_e80, "NV140=
WUM-N44 V8.2"),

Please sort properly. 0x0a6a definitely doesn't come after 0x0d73.

Also, from the EDID I see:

ASCII string: NV140WUM-N44

...it's better to use this exact string and get rid of the "V 8.2" at the e=
nd.


> @@ -1978,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N=
140BGA-EA4"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N=
140HGA-EA1"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N=
160JCE-ELL"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, "N=
140JCA-ELK"),

Please sort properly.


> @@ -1987,6 +1996,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB60=
1LS1-4"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE00=
7QS3-7"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, =
"MNE007QS3-8"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MN=
E007QB3-1"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE00=
7QS3-6"),

Please sort properly.

-Doug

