Return-Path: <linux-kernel+bounces-778096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54468B2E15C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD5A21D55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199082C11E1;
	Wed, 20 Aug 2025 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="C8LDnFfK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B4219A81
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703900; cv=none; b=U/qexGACILjvNrnh9CmthB3gGglvct/CHAU+BNhw6kaxjfr86qBUiPZ8T1f6qOVpnhvxwNta1rs8RAyhbikg6U+62IiRv8eOZDQlwZkoiEn1i3RTLNEE3W+ZFLdCne0l9+iBN0fObdeuCoEfJl2Fq6q5OqctJ14r0Oe1cjenVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703900; c=relaxed/simple;
	bh=10I89XL/l2GRS76lOXYnSC+MjwZsTherQYswe/RkQt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7f8epJo1MRTg5+mrA0B/5ZwASAN5nV0ibYvia0gng1Lq2AA5+3rwKDLQJui2cPKRSzUH6hJSZY3I7Ib7vCTDVywunnWpUZxp/CCZ4hmzRO5nxKsYkal7cizwKTv9chOPwm6V1lU2EPNVP3wCPvyXCq5839Id5RzROprsZ5UuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=C8LDnFfK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-245f19a324bso6479215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755703897; x=1756308697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CFiBinjOkqTeTTRLQMbijMZjq/eImrXz0BMlfgI32uI=;
        b=C8LDnFfK2ynDUobMq839AryvR6wprfGJkp70IrRuj+JByrV4SLDBm/74KO2ROiqTR0
         UHgsHYsEC5Bk14T1uiSSCNI3yDbfEYC7olgZwgL0/gI4258I4vK0qt3ZbZskdDpaDz0F
         l4aAqDUk9sUHUAOQ0eyqDlWU/ckSRe/SpgprgXl+vClQtmyAOvnY1y8Px+IgXK6y2rTg
         vmi3R7qZLdVFS6SVRwCUAq+OtO0Vj5gIIz1E3HWWpKJU6WsyF7/NaDmoHcosbQRaxatn
         dy7aPhYoev1oQU6JrUk01PgaqKYoF3OK0mRIVCV+/6BKS6tC0llS5DP++eZcuGrCEZOE
         U3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703897; x=1756308697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFiBinjOkqTeTTRLQMbijMZjq/eImrXz0BMlfgI32uI=;
        b=hPgBnA7+l6TeejONRvqY2ntUOvH1Xmo3uK7312vaCmPDu6Zkq7+EdjDrfEAWHjrTLB
         W8y72QxKjglf4x3sbaoK41KjGKlvQeKe86I8w7jDfOre5ot62H6PG6mDU7wJ1N2cGS+X
         Ed2RQIviE27j1DWLu2+trFatIxUrQwSU1euh/wIMUeh/1Z149/lmzagTSmGLythvX/aR
         KkttUgeRORb1xDYmgt26/v8s0okxahOtSWWPANionf+2g+sLkso7lHPqr0fRAi75wc1E
         mVbJiCzx4L8ODKj75dibtnXISsE3S6qg7E3nXbJD9LMUU85n6ySw3rtdmCt5ZlXESM5Z
         uYRw==
X-Forwarded-Encrypted: i=1; AJvYcCX1r3pwCEs3Ux8jd7dzISr5EuDuStc9H6rRERubqdTs4TO9SE5LtC2zbgRROoaltVJL/f3O5Ihxl12JlRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tMtYjDDAitcbcWv2eoAiBKpmT3Hhx3Zenr0/N/P7Q3RB2o/h
	Ubz28lnjyzfKPPQcts66yI0jJE3afs3OpxKD17aZqXV9Xud4ots6XjXOYrFScPtaSmw=
X-Gm-Gg: ASbGnctd0UKxRmGm3e0Qv3cJgW51lonrP8T6wH6Y0syhiiybhURDI84Fg3INlgw8+y3
	k7NITo7g+wYh1EXoHn3H3DJrqjNGdVbXMMZImWgkjIDsM9QaC1vubfzbM6lp5Kym0SmFPms8kEd
	w31M0PzrRa4Z9iuq9mctCsrwHPfHkMaQkOCNfdb5RpnVikizxn5bOtaM0eLkaP9bR+3QI6//zBv
	6OI014bqyJ+4eSm95vm64SSFA3mn6aAp/0FG/4B10NqblzrgbS+kI7OcwSY36KHE2mYcD0OTgHi
	sIVXM3WMk7AvmBu6/bTKNiEsg/acq0etKDYjl0I/Xl5tjOMLD8bzEZH8c4rEX/SzeIEsJ0OhACg
	ppDTAhTsb+J4pOIx1droqoAMq
X-Google-Smtp-Source: AGHT+IFa+65EiF5gOLmsUqiKDfGi/hjEovv5LFIEhAxpf/e3lDkv/Vl67MHoAyiAjrypV/nXob9hNw==
X-Received: by 2002:a17:902:f98d:b0:240:1953:f9a with SMTP id d9443c01a7336-245ef0bd96cmr33559625ad.2.1755703896739;
        Wed, 20 Aug 2025 08:31:36 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm29774255ad.134.2025.08.20.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:31:36 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:31:34 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKXqVqj_bUefe1Nj@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>

On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
> On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > The same naming regression which was reported in ixgbe and fixed in
> > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > changes") still exists in i40e.
> >
> > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > ("devlink: let driver opt out of automatic phys_port_name generation").
> >
> > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> 
> But this one's almost two years old. By now, there may be more users
> relying on the new name than on the old one.
> Michal

Well, I was relying on the new ixgbe names, and I had to revert them
all in a bunch of configs yesterday after e67a0bc3ed4f :)

Should e67a0bc3ed4f be reverted instead? Why is ixgbe special?

Thanks,
Calvin

