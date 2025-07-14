Return-Path: <linux-kernel+bounces-729752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5DDB03B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E99E17D91B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546F242905;
	Mon, 14 Jul 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KejoSmio"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19117242917
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486087; cv=none; b=iLbv8U6p/ez6yZmol3nrLy7EYnnC+LyfJ0pOkW9q1IYAbJbtwpDo2dtUi1e7q8OcMrBws8/mXxfnpBcFJUWqyTXquW/E/WhIwgdi7BzItbK9ct1Gp/SfXk0FN1rvbYvJTbKS0wvNUR3oIY4RJyAFkt55s3hNtnQRvWGVaGa1Yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486087; c=relaxed/simple;
	bh=n5Lu5XOTpaqQw3NG6XcbWaT2VD/8k0H91jd32Utli2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPi9dC6z13TqRZv/lPa3Dwp4AeTZxCMeFg0JWZ5nqubrIn6UcolPJP7QNS7Nw5L/qhHmWWKyR5XIr9uBl2DEr2sWgSGOzc0ffyQ+OYYhU3/Ff0Twd/ciRNsKEI54+z5N0dEYXDt+NqUQONyAoKZ0jG7G5cIqIAfDqFOi9Ey8thQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KejoSmio; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-528ce9731dbso1671245e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752486085; x=1753090885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU1pXquz5m17ppHnM/H5OXudY9qX0uavP0UPxLh54JI=;
        b=KejoSmioXgSXEesy040b3uaIlgc8kM4InwkHNjbuBaNXcbBWvjT/rg2nhDnT2OVOXm
         SuBRIfvjoBQPVvX/fIzK8YH4HhRjzs0mR8SWWUFH/NqWlDWBZAcs8UflNuRjCSkzPFld
         ms01pUVuAawZyrlGncPaHr+aRNMkHnddWE8H9fiz1U5+23Wjxpocp/iMNEXtVbJ3gBze
         /S1lSXHefeKLun3w0s1FWyeQhPiA0s020STbwRpkt0gjksaQLZVyp7pnEhQXIDIanq8s
         wj9C1nKtTJNo9GTpiudvC8XNGavM8GlD12H/vMg/r7lqDf38avvVzRXL9KdoWO8iQp7L
         k4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486085; x=1753090885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU1pXquz5m17ppHnM/H5OXudY9qX0uavP0UPxLh54JI=;
        b=sOUxCL/I+x8Ru7PSdYi2m62oSeHRxqsK2EXm3iTBP5q4et/9O0ynSxtv7HJxVV2Fu/
         1CJGa4UNLWaklcPgnaM5UP66TxWxldliY2o1kHehx5QIo7s1mvOEUKWuy602chAevwr/
         0INf/FITZJn7H6NA4doQXrCs8RPplC+NrIf0nkjpS5pN8q5mr2OCapYcXXsooVAZrbVl
         I4gmNzejiALR3tCc5tOx2I6mmqwZ8ZNeuGAUOfGH2TMikg1bLU2RQMVHc62AqDAD4aCe
         tLSL6oHtdnFRDj3I6PIp1TCskzcT2Bdi0U9K6zBe7vExuOe59DbtPuA/+fcv6sMGW4Wm
         3H+A==
X-Forwarded-Encrypted: i=1; AJvYcCWseWBCanTr/ANwoBE9mQuTz/nqRlZg+8BvfL7hUu19B0g/K6N+xE2ONXUT8QL7o8sHWIC0KAmiEtTmZ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0kOGqDMfS93Fr9Y//C82ShDUi4H5Nl+6FhBf3Km/wOXW7S+H
	GNJxauJZde+fzFIZR+hnyQxjrwq5Kmyta3+s+kVZh+cWISbpU04A4UIUR2H8eAZYXUEu+cpRV9n
	lZz49x8Cnt38zGT+4AKGKMxQQVRe4135STEgCH4Yu
X-Gm-Gg: ASbGncva70eQmoAdTD0fa+TRGTANadPvHFGAnzC/LI7RZN95hg//mVqTos3pL1UMDAk
	5kfdCp4ZD5N5C+NU4B5Is950h6jJhf8F7ZulGHWK2lJaMzZhJ0ImnQVhq9n6GB8RUyPA3zA3oVs
	tN+tVgpW0su9TWqIp1tw2cfGMACJ2jZcpeIkLbhZChVsOsD5dKnwl2V8ve4FwuPNdpQeF8wPXJu
	CHzg8e5QCEIS0CX8ifgknfA2jYbJo1jXQHBbQ==
X-Google-Smtp-Source: AGHT+IFxSzlutg3Pr/kuJr9QcokjyqheRjaROrcSK0p7vB3ScvIabN1URNDypACOfW+Jtin3u0mNdSX16+UiCvEDj7g=
X-Received: by 2002:a05:6122:370c:b0:530:7a17:88cc with SMTP id
 71dfb90a1353d-535f47fc9f1mr6473291e0c.8.1752486084756; Mon, 14 Jul 2025
 02:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711003502.857536-1-raduvele@google.com> <aHCO3ZqIFYJu2YTn@google.com>
In-Reply-To: <aHCO3ZqIFYJu2YTn@google.com>
From: Radu Vele <raduvele@google.com>
Date: Mon, 14 Jul 2025 11:41:14 +0200
X-Gm-Features: Ac12FXz08eJ_XcNTrForjQEtmhRzOPZ0DdFbUc_mzKvYEq6_AuyQEv2SskrS_Lc
Message-ID: <CACKy9TKdJ=2HBwxJ5AnMCm6xHA1fxtkv-Zqn=Xr4xt-7P0Pn+w@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 1/2] platform/chrome: cros_ec_typec: Add role
 swap ops
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:11=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Fri, Jul 11, 2025 at 12:35:01AM +0000, Radu Vele wrote:
> > Add the pr_set and dr_set typec_operations to registered typec ports.
> > This enables sysfs to control power and data role when the port is
> > capable of doing so.
> >
> > [...]
>
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux=
.git for-next
>
> [1/2] platform/chrome: cros_ec_typec: Add role swap ops
>       commit: ab229c2b72c35739e8ffb70af11190ff40f38701
>
> Thanks!

Thanks, please note that in case of the power role swap I started a discuss=
ion
with the EC team to verify the assumption we introduce here (the resp.role
populated by `cros_ec_cmd` should be equal to the target role if the operat=
ion
is successful). During testing I saw that the `resp.role` was not equal
to the target role but the role swap operation was successful (I
verified in sysfs
that the power role is the expected one).

In case they advise that our assumption is not correct we should remove the
assert resp.role =3D=3D target_role for the power role.

