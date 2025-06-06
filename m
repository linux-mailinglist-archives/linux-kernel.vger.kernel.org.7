Return-Path: <linux-kernel+bounces-675537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E81ACFF1A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3DF16FFDA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D80286897;
	Fri,  6 Jun 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="I4Okap8r"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCA26B95A;
	Fri,  6 Jun 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201563; cv=none; b=QWlYIpPDpwAcCV1b9nJXbhTerBAhFQ2QTddv9T58vkquzubplo3zeW1PKMcIe2J0oSkL/9hPbJFfA87bCjdX/fgBSPVtQgI7Gfo3BspxZUzY7H3nnnN0mV7af4l2M9ByRO6TIqg5NBzcfvOAxjv8SUoCvFvQf73483lwhT7N5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201563; c=relaxed/simple;
	bh=tKDi5g+WJYXkiDu84THtecwGQt34edB7qK5WTJ+hv1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE2VVARr5o/cAR6ck0oNSkkVEoyojKtnpq9TBtMKiEsCyVSxojJFQlUaRVlsPM+D9iIWh6z06Fdd+h3+eiCYMc5ElOxnKi9Ksrfy1mXG1JfkZ/TgIOjUhTJY3L7jdLR36qLxHFT1QrDnN+AjTVEkwMiH963A8FbReIj160u6p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=I4Okap8r; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1749201556;
	bh=15QNaksYI2zs+1jCXDG0pPlORekfTpURDzMdJDiHTJg=; l=801;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=I4Okap8rXVG3dJqrjFL8jak2qvriNzOzi/OA7XxTIWulnumdOPOSoFEk8J0eEeVg1
	 uFqJxTCR9LrZNWBaChXSbZ887Qqbf0au/iouOtRxKfTyNgA314nHUPPjn3xmlBUbqw
	 OHfQuioYRyBBVz0tNAZSe1m+a92IuonPhhSkyjjIvR62Detrn8yXdKq15P2zfKWd3K
	 jc4XifX870bWtWKkcGC54XQLrc6ibBMRZnBg73OMjTRKxsaP70sxeSOb0lvk2QJs2N
	 GKMX5s7xgixoCUKEg1R+suyyjF1Nd9o+1kn9mlsgd6BmBA4CJoWRVvxmodrNv0jKBz
	 Pw5UZu960mSZQ==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2288495:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 06 Jun 2025 17:18:57 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 17:18:57 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Fri, 6 Jun 2025 17:18:57 +0800
Date: Fri, 6 Jun 2025 17:19:12 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Roy Chiu <roy_chiu@richtek.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add Richtek RTQ9124
Message-ID: <aEKykANxE/v0UN1b@git-send.richtek.com>
References: <cover.1749197773.git.cy_huang@richtek.com>
 <b95d701e5eb93d011a9e428adede845a309d1f12.1749197773.git.cy_huang@richtek.com>
 <3853e99b-30bf-4263-8abb-2b9f812415bc@kernel.org>
 <aEKqGS8xGKNL4WxD@git-send.richtek.com>
 <d923e0a2-acee-4e25-80e7-cdbc125408a4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d923e0a2-acee-4e25-80e7-cdbc125408a4@kernel.org>

On Fri, Jun 06, 2025 at 10:50:14AM +0200, Krzysztof Kozlowski wrote:
> On 06/06/2025 10:43, ChiYuan Huang wrote:
> > On Fri, Jun 06, 2025 at 10:33:46AM +0200, Krzysztof Kozlowski wrote:
> >> On 06/06/2025 10:24, cy_huang@richtek.com wrote:
> >>> +
> >>> +allOf:
> >>> +  - $ref: dai-common.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - richtek,rtq9124
> >>
> >> Exactly the same as richtek,rt9123. Don't create same binding files for
> >> similar devices.
> >>
> > Do you mean to expand rtq9124 description in rt9123 binding file? 
> 
> Yes
> 
Compared to write a similar file, this should be better.
Will use that way in next revision.

Thanks.
> > Any example that I
> > can refer to?
> 
> Majority of bindings.
> 
> Best regards,
> Krzysztof

