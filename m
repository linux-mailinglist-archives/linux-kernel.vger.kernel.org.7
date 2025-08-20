Return-Path: <linux-kernel+bounces-778654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B58B2E888
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4AB7A04DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9C2DCF6F;
	Wed, 20 Aug 2025 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TgwGAQPz"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715B2DCBE2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731778; cv=none; b=DvQIQHSg+o7gOvY+GOsVJt2F07rQ7/0Pc0ikPxVrDYRbxdiInX59rj6BUPL7Xo4yTgJ+TEpASNa+vifRaXWyeTy/u0L8xJtvv6lHu7FspvhthSsdGK/qx7X8OWKCCMfXpJO6qZ19xhO1+MAowaXVrmIhThmjW2Cebg19ypLs1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731778; c=relaxed/simple;
	bh=6f0OjFlV1PzsTYz0k2fuECClEipa1HTYv8zSt89S8Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtrHrxX7BAoIw82rcH4CJboQE4szBDvXxIYg3mtcqs6vfRqyP+5N51TDWyiXwjNdAAW2kj0Cft7AnfmcJcuQf9vmeQ1dnvc/HlvaQV442mq1aUfYfIBn5AmCPyWMkLE6oaXD8omihHLQD150gfeEZttrtxi0vANUjISXm5/60h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TgwGAQPz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso353057b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755731776; x=1756336576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdmO92QeKFhs1Z4CeOhnLytcdLJZgHdRK99IKc3sAMA=;
        b=TgwGAQPzk08W+TqpYpvwXQh9SWWTUiwfS8s0n1NPiBKa+dXjGMLn+YJELt8HLhhYk8
         BYG7I33ooorUOWQ/IS+S1CsrZgWOloFWdB0IQkKtPavIu/XQdcWj4pBlbCs274ocg98r
         rbg1OFepnyjoO4i2UN516M0019CP4l1cWqvgFqvUrJWEb5kbiMceEaL7qkCBBYbXQo5i
         Z4xE9CtmbTiK+YfTZmC32SM2tPjOKy+PMiEkCMSZ+EaxDB0Yme7n4VzfSgaxtlPs2LsT
         oloajqgI9UUW+HCfKwLVzIs2t9Wd0Lu36lN5F05ur9p3lwvytbG+etGC5YQGBHVeTS9E
         qV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731776; x=1756336576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdmO92QeKFhs1Z4CeOhnLytcdLJZgHdRK99IKc3sAMA=;
        b=fX88f+17nzfB+jv3elbLHPCTLR5pLtL/qk/zgAnh9NrFQqo8AKycVa0kOglxw/ywtB
         ZMgqPCATFnykzSzP5Wjkmj+rlmJwIr6Rq/bX1ZaBd6blckn+lqaoo5fDGGb4J8+7w0Ah
         Hi9i2kBRRO0MiNCBxcIclkUU3bXlBAUgolbj0FOAK0cOIBtC7oj4KrOI7i2RY9HpXg7C
         8FV3Hmpo+FAxw0cgL7b5Fvt5EZgyYOVnNXN6HjeJWUPgqgqM4/OiRgdVGcfu5Lo6xUII
         L4YjI+9IvNzMBdbcNDLZXeRtO1dXMh9jjvSGiFQC0MGaLo0+7xjOhSCb9hiF+ikGYmQ8
         nrnw==
X-Forwarded-Encrypted: i=1; AJvYcCVB5j2W//kMLDCYNM22qHPk22HgBZaLPvUnbx1xupU6TWCa4BEPlMMmS27VJQTwFBAEnu28XZY5h3Te+nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSiXfdvy3Zpgi61/BDoh6JUZjDabPPmXMlSWZ4Cla8OjMLTmZ
	hktMvNh1ccPYlnPKuamc9gM2DCDD6HA7NeACSR3J2nQuAcBY4hDRZ6O1XUekzXrB/zM=
X-Gm-Gg: ASbGncuys2/ppohf5HlR+jlx8AsHB4qC5A9E9RYlU542skd3z7ROG+3voQP5bGeyad5
	OIhH6fJFgQZVEXbGXsjupQLUln5t7xO95u8VN6wlaa4qacvOAs8A+S4J3LeAGUFBZrk9m6lxzif
	87I4olb0x2y60+jqy8UB6n9pNyTH6HF765RoZw+TtUXYaHQ3ZQyMJIsMUFEDMoUAySx1h2nQoBY
	dyF+iz2U+0t+v+fNvC4gLVcMu+32m6auQ7kJMTkURUoAeYSliQNR00LAKdce/U8Kp2W8Cba1rvT
	VwQsQNAkCG2Dgqa5QbW3zoOrudHeYVW+z/yScsjZTlqqsAKCgQp9m5YZprEqH04JBfch9hhL2zZ
	lioBAL00/tX+GS5DHmjA0A0ec
X-Google-Smtp-Source: AGHT+IEKHsFSPmxTNhzwI6KtHFTxUhdcM6HLPvQhyeSQbdETk31i7U+6s5u/zjJ0+1bHbJoJ9YlFCw==
X-Received: by 2002:a05:6a00:189f:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76ea319b6admr398666b3a.13.1755731775792;
        Wed, 20 Aug 2025 16:16:15 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4fa87esm6403467b3a.65.2025.08.20.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:16:15 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:16:12 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Vecera, Ivan" <ivecera@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Prevent unwanted interface
 name changes
Message-ID: <aKZXPF3VgmwSA2up@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <IA3PR11MB898643CA16052892963547F2E533A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB898643CA16052892963547F2E533A@IA3PR11MB8986.namprd11.prod.outlook.com>

On Wednesday 08/20 at 15:51 +0000, Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Calvin Owens
> > Sent: Wednesday, August 20, 2025 6:29 AM
> > To: netdev@vger.kernel.org
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Jagielski, Jedrzej
> > <jedrzej.jagielski@intel.com>; Vecera, Ivan <ivecera@redhat.com>;
> > intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH net] i40e: Prevent unwanted
> > interface name changes
> > 
> > The same naming regression which was reported in ixgbe and fixed in
> > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > changes") still exists in i40e.
> > 
> > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > ("devlink: let driver opt out of automatic phys_port_name
> > generation").
> > 
> > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > index cc4e9e2addb7..40f81e798151 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> > @@ -212,6 +212,7 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
> > 
> >  	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> >  	attrs.phys.port_number = pf->hw.pf_id;
> > +	attrs.no_phys_port_name = 1;
> 1 is acceptable, but kernel style prefers true for boolean fields.
> Can you use 'true' instead?

Sure, if this ends up going forward I'll do that in v2.

> >  	i40e_devlink_set_switch_id(pf, &attrs.switch_id);
> >  	devlink_port_attrs_set(&pf->devlink_port, &attrs);
> >  	err = devlink_port_register(devlink, &pf->devlink_port, pf-
> > >hw.pf_id);
> Thank you for the patch aligning i40e with ixgbe behavior to prevent unwanted interface renaming. This is correct and minimal.
> 
> You're adding attrs.no_phys_port_name = 1; but there's no comment in the function explaining why. While not strictly required, maintainers often expect a short inline comment like:
> /* Prevent automatic phys_port_name generation (see ixgbe fix) */
> 
> This will help future readers understand why this flag is set, what do you think?

Hmm, it feels a bit redundant to me: "no_phys_port_name" is already
pretty descriptive, and the details (with SHAs) are one git-blame away
in the commit message.

> > --
> > 2.47.2
> 

