Return-Path: <linux-kernel+bounces-616854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E73A996FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9335464740
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85A28A1EF;
	Wed, 23 Apr 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="flczgPhJ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DD41C69
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430527; cv=none; b=u0dklD9zJstkVWgeAnLbzAgFtOEAM0sHYklZkb0Bh4MXBfxZCrEkDoyU6qDIUuaWl3n3qj14fhUq8n7a5dUgqOmi+ifK09wbvEi+GU5iONiOX7RonX4588NZ6o7K2c0dXPVXM32vboPjZatCZlyuiZDlSVJunfIMQK0c0KBvtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430527; c=relaxed/simple;
	bh=3FNguulO/qyzIGlULRCSXYiQu5VPk19bxekq9naZME0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7IVLl/8WyxltCDnVoeXVzWe2TelJSu0hDRmGsb/sXfkzl8noZDh1/8kkC+zR0WbH788r9Hn1u2CFU5f/ujBq4NhDREsgwJnJBP8uHTghNr1UfVig2ecKKz4o0iuPbj7mBiPw3D4+xGdEZsyVvdbiPbczUM+DzuUmGmmZUVZt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=flczgPhJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pQtVtfjcISAXVaI5AkP35trRWt3Y1MNmZDafxANLqh0=; b=flczgPhJv9872LkI9et9T6x2/0
	OPgsl+sGZke1RUeQyscDdDs4GZCWisrK1xr6Ywv1u5BG1MsOWYrM/LuT78pfbIJI9AschGQVFUq7Z
	rSBUNfbbyK/d8iZ6ZCflpEVTa7EVx4o1ogXzL77WBvUmdrj7ec4xaE7CVlOfYSKVv/zoJ2kLeXPVy
	IoK9Dz+c0hfOYoCs2+EwPsP7b0N1AbrfT0pRgIw+5nZsvvTFrIGWO7adzV9Kpb0GEEY3vXMJp1PFi
	oDQfH42qZeCPYQ5kBE4HEG+MhocFyF0AoXaVwVpnKRLEb4yHiGQSE839LjU+Hmr+JZdHzyddsp+vw
	9gb86kKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45988)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7eD6-0006Kz-0U;
	Wed, 23 Apr 2025 18:48:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7eD4-0000Dl-0q;
	Wed, 23 Apr 2025 18:48:34 +0100
Date: Wed, 23 Apr 2025 18:48:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yury Norov <yury.norov@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, andrew@lunn.ch, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Subject: Re: [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field modify
Message-ID: <aAkn8lvzoa1grdkt@shell.armlinux.org.uk>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
 <86r01rjald.wl-maz@kernel.org>
 <aAJsaNdznnz-1qap@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAJsaNdznnz-1qap@yury>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 18, 2025 at 11:14:48AM -0400, Yury Norov wrote:
> On Thu, Apr 17, 2025 at 12:23:10PM +0100, Marc Zyngier wrote:
> > On Thu, 17 Apr 2025 11:47:11 +0100,
> > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > 
> > > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > > - reg &= ~MASK;
> > > - reg |= FIELD_PREP(MASK, val);
> > > The semantic patch that makes this change is available
> > > in scripts/coccinelle/misc/field_modify.cocci.
> > > 
> > > More information about semantic patching is available at
> > > https://coccinelle.gitlabpages.inria.fr/website
> > > 
> > > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > index 34233d586060..b2af748964d0 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > @@ -30,8 +30,7 @@ enum pkvm_page_state {
> > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > >  						 enum pkvm_page_state state)
> > >  {
> > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
> > >  	return prot;
> > >  }
> > 
> > Following up on my suggestion to *not* add anything new, this patch
> > could be written as:
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > index 34233d5860607..08cb6ba0e0716 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > @@ -30,9 +30,8 @@ enum pkvm_page_state {
> >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> >  						 enum pkvm_page_state state)
> >  {
> > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > -	return prot;
> > +	u64 p = prot;
> > +	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
> >  }
> 
> This is a great example where u64_replace_bit() should NOT be used. 

Why not? Explain it. Don't leave people in the dark, because right
now it looks like it's purely a religous fanaticism about what
should and should not be used. Where's the technical reasoning?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

