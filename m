Return-Path: <linux-kernel+bounces-721541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6971AFCA99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C725D1888EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE52DC353;
	Tue,  8 Jul 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXXuokV/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C42DC340
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978459; cv=none; b=PU2UP6Lzp5kzE6QaW1b7I45+KxXDedf+oFHL7ftb9QQRnZpd6owmx6aa8oU62o8fW11j1xqeQy9aSNRKdCLhBROsJRBxWC24RCIy2TUI9VAzP36Yzn1s3fTgU/lUD0HRwHVJXauDZNCILLT5V12HqU2SMlDXheaNyCUNruI5fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978459; c=relaxed/simple;
	bh=sZgy+2j2K3WzsQyJuAZKTI3O3KoIlloG7CaYncgcPSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFHM17ADTIBZUn4CoAC6a33ygH2qunWRIol/slb2HXxAeqC0J2Y9EQtYsCKwsKRrv3k6rbMIpyO8hMvFz6KeBXtUAXzYvlzo2RQKtuJ1lR8B6B5p12PBq+YxqOFki/XttVNDNDNO+aZ1b3DwGjxpznY56pitKbZ52xB14IA6ClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXXuokV/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751978456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZgy+2j2K3WzsQyJuAZKTI3O3KoIlloG7CaYncgcPSQ=;
	b=FXXuokV/63GDlZbrQY7oaJXV18aR5/n+XuO/nuLHG/JYszyw8+83Rf6VCkeP/41Y0sk8ck
	sg77rmDfpbM2Aurx/lHkyWMwp2NpyUd4NfNDzRJAMJZtxOcYD5I2Gl1pFgdT4OV2DUViRt
	/aqypbP4P+JAIPsR2hu+OmbWbGcIajk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-kh-dS3BiMeW_e_g3CiLEjQ-1; Tue, 08 Jul 2025 08:40:49 -0400
X-MC-Unique: kh-dS3BiMeW_e_g3CiLEjQ-1
X-Mimecast-MFC-AGG-ID: kh-dS3BiMeW_e_g3CiLEjQ_1751978449
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d07944f29so900844339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978449; x=1752583249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZgy+2j2K3WzsQyJuAZKTI3O3KoIlloG7CaYncgcPSQ=;
        b=QexD4VHjcPKddBjZEH/rZqSv47O5KDOFZUrrqt9T2K5/ci4vqs2h31gB+0oEPAzNRm
         trnnVuyrn71I8fbriTkROp39VAUQBGXElvvh9Nga6/k4COY6fQA0YX31Vh68jzxHq7hC
         Rt+1xa04GM6WtOhF5iN90sqJ4llH7rzjJvHzCFyw6V/+WZF2qnNYN/o2MMhlSKlilLcJ
         eKIjaT6QaNKSZCHLVcAkJSbIHtjZbIpX1B96vuu6hBRge+Ez+9X9/WlnCDYpcgKQzbaf
         sFsXYhMDvj4oaUEDAv3iWVl0rTBqDOwkiD8lqowbg7oEDPRlLwpZHRhf/aXwy+3nYQ6u
         Z6vw==
X-Forwarded-Encrypted: i=1; AJvYcCU2H2bDeSkRhf/NMB4Iww/74kZFi548WfHhtfvkqXTUlVBkcCkQKu1E8PfSHwk4rDDn6jbZbk4FINpJTRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+SWiYuLesxqJUnz2/DxUETYTs1iggm8reZjloYG3tB3lnxO7
	D7O2FxvvHSLlqWfi/pw39pJmVxpfHWPxN1aUORjNSbfx/VPBZEYpUnpJ9gs0U164L2WRHmJAPUw
	S6ZHvUbk53Kdsabcn4hfSXYHbeSSTjZo9tA8PpC9aUFXV2NLl1I/mpLmyq9L+gb0M4oM0pzMfLd
	9USgqREEmt3WmMtxVZGK4VY798pBtstceRKq4NrHKw
X-Gm-Gg: ASbGncuPM9AguVj9s3seWUbTlCeYgXXDry+0V/hfaAyUsqqSILTA+g1e7UDcEyPusBC
	tk5jvWx/3K26vAVrl0MmMb1TgXyGlc0juJXz6EFVQej7m+YKWZJ1BgPukVSYysSJKXkwMUCMleT
	hmoIiCtJb4gjHN4AOfPCoaBV6VxTLDD12ZJiIp
X-Received: by 2002:a05:6e02:378b:b0:3df:399d:39c9 with SMTP id e9e14a558f8ab-3e136ee4883mr168223475ab.2.1751978448973;
        Tue, 08 Jul 2025 05:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbYQNxogXNb0gyjlqPtcxhl5oMTYJhToH8zjakQAU6t9/EvkvuHsM0HVhMBlaDZoS8YMJX5m2laPyTVKhbMaI=
X-Received: by 2002:a05:6e02:378b:b0:3df:399d:39c9 with SMTP id
 e9e14a558f8ab-3e136ee4883mr168223185ab.2.1751978448642; Tue, 08 Jul 2025
 05:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701172556.117872-1-desnesn@redhat.com> <45b69c6c-e8d5-4b71-9759-cd76eb1a7258@kernel.org>
 <20250707125028.GB12247@pendragon.ideasonboard.com> <5fb10c0d-eb85-40d1-97f2-9e36d4d1f62c@kernel.org>
In-Reply-To: <5fb10c0d-eb85-40d1-97f2-9e36d4d1f62c@kernel.org>
From: Desnes Nunes <desnesn@redhat.com>
Date: Tue, 8 Jul 2025 09:40:37 -0300
X-Gm-Features: Ac12FXxVXj_P9emHoRCBl0bPdB7pJ-2pym-GcvgypQJga1tlAgn2bTryvQbEYR4
Message-ID: <CACaw+ezKVQQcRBgmL+UD937aXqRXUfu8v5ycbOi0o-9p+Ky0RA@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: avoid variable shadowing in uvc_ctrl_cleanup_fh
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Mon, Jul 7, 2025 at 10:01=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
...
> > As mentioned during the review (see
> > 20250701192928.GB16835@pendragon.ideasonboard.com), I still prefer loca=
l
> > loop variables. Can we use that please ?
>
> Ok, I'll drop this from for-next.
>
> Desnes, can you prepare a v3 moving the toplevel declation
> inside the other loop please ?

Sure, I will send a v3 with the requested changes today.

Best Regards,

--=20
Desnes Nunes


