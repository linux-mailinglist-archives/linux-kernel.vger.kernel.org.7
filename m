Return-Path: <linux-kernel+bounces-777021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B952CB2D42B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A8A5883FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AD2C15A3;
	Wed, 20 Aug 2025 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e04yP6db"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255118FC97
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672176; cv=none; b=CMWyXtBSUG9nbrD71PtUtzaVtx9zgMjWs49bErTdtAzJxF6ZMnL/LQML0Xn8hFYDcBE7OzrFWP7peg+ManMnc6zZPETlJv4v3VE4GwK4r2htf0Ixqdb76zUbkxs24mILrokFj8KWazU5lRYw/LVxIcvNFB3LjHLIIqOmjzn5KN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672176; c=relaxed/simple;
	bh=kDL/Idwe3t8gh4wpRKhxN1+hNKjitofyF+BnAdqiTh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNoEnMzDwrW0bR8zm/oOzzPqVzclEiZYeBKwxhFXi9gV/Ibp1ucZHVlKdwe9Jf216J408rUTzZjzqrv2valauGzYxbGkjIF18U4zgZm9n+3oVSEYchRp7y+XcV4fwPT0XoRlU/1i0Gq23S2eHCsBAJjjJYRv+N6YrMfxndDJ+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e04yP6db; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755672173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDL/Idwe3t8gh4wpRKhxN1+hNKjitofyF+BnAdqiTh8=;
	b=e04yP6db87f5DIEVs+9TGnm4RpE9tYbWRSx+4iRNnf7sNvvbUkJIH9WGpObSPZ8vNFDrcC
	oXXb58nQwtZ/zeiblBac0VNL/5GQ5HOaoDtByST0JSXF1mg61KiffiEufyWVMD/0ML+wHK
	9KMxpH26hIVL3uaGJwN2jEashCfcUaY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-njy7Ba4_MeG1Uh7Kj0l2-A-1; Wed, 20 Aug 2025 02:42:52 -0400
X-MC-Unique: njy7Ba4_MeG1Uh7Kj0l2-A-1
X-Mimecast-MFC-AGG-ID: njy7Ba4_MeG1Uh7Kj0l2-A_1755672172
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30ccebf87ecso3298132fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672172; x=1756276972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDL/Idwe3t8gh4wpRKhxN1+hNKjitofyF+BnAdqiTh8=;
        b=sJb9BuTRMeOYH7DWJ0t1Ubqd5nWhhjnJjqnx4m6237FLieyuhN5lT8/lyJdMcAqGnk
         uqMVHmVv7mIKVZXC6Sy0xpwO5Ax36qGHCglCQFHlw/3YqGvANucjncy7v8YvquN++bKc
         DGb3qlIYh8l4N8wetG9oPnbYbX4OZYjori+IstILRzOU+PjjEl/XPqJ4t5NeRShMaW18
         hr59NOyzw9IVSN66qlePtvqqwPn1vMfcGsiU7dsUzxURhwUjd4kT/ZUVw4OE/7VZeWk0
         iLumPuzzuscdHba7atCZnGtiL0ecEP8nEVmhCAzljJChwgubCfMdZJxT1V87w/GOOiuK
         pLBw==
X-Forwarded-Encrypted: i=1; AJvYcCVD99hayuFCS08CY7w+vJ/rxcTVpVYGfK6rWhUVQGrYl1ZaRT4tpQgPbqPPn6uImFnpfGJNMfy9p2bnmzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tGQLjknTSJTU4dIKLyV6w9sGr/JufC2J9lElfY2AOD20xA/W
	7x9H40fc0/YNu07uKI++2PHh9l+PlrIoVjFG0DzXe6rci1grcRpVT5kR5l+YX9lyZ8Lz1SRNNcT
	loqEg/6f0krc8qJ8/ttHqtZ+OKRB6PtfimuHR1KPscARtLFR82J3dFpenvAZDFYaRyto/NTa5Yg
	5RRD+yFieDjZ4Fw0F2mV9ESFaLiKxxQ+BCaUlaYvB/
X-Gm-Gg: ASbGncszmx5HX4D//IaEW7C7VSXthTSFUduySdKoypOT4yPdkJT2zcLd49Qzf5k8nyk
	Nyz8PgqwYddDpO2slMXW0mdhDPJsRhjs3TaHCUCffuMGsKVbwSkZQx7sD0vHUmxpncs3R8kYZri
	0y3ylCGIkVkbKBn94bBegB
X-Received: by 2002:a05:6870:c1d1:b0:30b:9344:3e55 with SMTP id 586e51a60fabf-31122747e63mr394751fac.2.1755672171751;
        Tue, 19 Aug 2025 23:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmLsvhdtdNVk6JDmwRGF8bGjSFVPu98lgSRJzbf3timmOPy0qWyeyxDg9OJD2L6uQ8lFu4Sls5RfCV9HwHwHY=
X-Received: by 2002:a05:6870:c1d1:b0:30b:9344:3e55 with SMTP id
 586e51a60fabf-31122747e63mr394737fac.2.1755672171431; Tue, 19 Aug 2025
 23:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
In-Reply-To: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 20 Aug 2025 08:42:39 +0200
X-Gm-Features: Ac12FXxTDI61-OFqLUbUeEfxXMo9_2gsYELc-tIYCgHs3iI0oJh3Tnjv-MNggJ4
Message-ID: <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
To: Calvin Owens <calvin@wbinvd.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 6:30=E2=80=AFAM Calvin Owens <calvin@wbinvd.org> wr=
ote:
> The same naming regression which was reported in ixgbe and fixed in
> commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> changes") still exists in i40e.
>
> Fix i40e by setting the same flag, added in commit c5ec7f49b480
> ("devlink: let driver opt out of automatic phys_port_name generation").
>
> Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")

But this one's almost two years old. By now, there may be more users
relying on the new name than on the old one.
Michal


