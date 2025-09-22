Return-Path: <linux-kernel+bounces-827606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40443B92330
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AF17A2525
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DA3112B3;
	Mon, 22 Sep 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp5LKM+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA82D29AA;
	Mon, 22 Sep 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558006; cv=none; b=UY/HM5IO5TWVFzUhX1GUwYmwoOnKgSqw+cV+N98rzm+YnVlPgxsNrA7TkbR97x51vAVpFCSAcso32sLCo4kFK2JHiP4JS1n/CJsc9eep1xL/0LYmjpxSETVbyTGK77j5D2LM6kJ6C+jV7OZs4aAqTjO/iqyv/HgGWv4yG9vY6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558006; c=relaxed/simple;
	bh=UDzTUX/zmLv2BwCZUiNWz0M3koAteLBl9RCNPPixCuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdJWZjF3i+zXx+O1GWXhlgS0Y1590PtBzObXzsXoXL2v/dbvkoxz5w9SUCTMclArhYqP86DD+DBSDPS5ho4S2wqjaj7LiAoCk46f2rmvGKPzX8fE+NOAoeXKoo8CZjveriUHV3Ebyz3llgJbm+xwlbCgNh+nLYwzACDJxGxC5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp5LKM+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F59C4CEF0;
	Mon, 22 Sep 2025 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758558006;
	bh=UDzTUX/zmLv2BwCZUiNWz0M3koAteLBl9RCNPPixCuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp5LKM+OOxHrg0L5s+b2Dbs67l4jIQgzcDHAQQiHS5oT0ibHcwRM9om66C5RmyCoF
	 5gFT6k7vmuEgssY6bwMibTiZrlyVtk9f5rB12SjYFxdSQYdaQnh/8/2C1YoQHgE4mB
	 cuv8tDLU7RFBfFgGwpwq4L7/t4eTEmbjcNS8FWZ/BtrOeG8YxYu77o1q5PeEoYN1FZ
	 UqNfzeBNGimmRYvJe4Q+Z+dwlvbwNpCBtMsPKhlI93d3jISBST2kfvxli3ncIvM66/
	 n7vLvD46BpLaz+xjqlixn7nJ66/8G4EjJQk+mOCU1NZ7vgzay0eKsEkiNSBArKZZYT
	 ucU0/sjbjp2Ng==
Date: Mon, 22 Sep 2025 11:20:04 -0500
From: Rob Herring <robh@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113
 devices
Message-ID: <20250922162004.GA199858-robh@kernel.org>
References: <20250915-undefined-woozy-15e27ca89a36@spud>
 <20250916063342.4436-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916063342.4436-1-flaviu.nistor@gmail.com>

On Tue, Sep 16, 2025 at 09:33:42AM +0300, Flaviu Nistor wrote:
> On Mon, Sep 15, 2025 at 18:18:51PM +0100, Conor Dooley wrote:
> 
> >On Mon, Sep 15, 2025 at 08:08:18PM +0300, Flaviu Nistor wrote:
> >> Add a compatible string for TMP110 and TMP113 devices.
> >>=20
> >> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> >> index 96b2e4969f78..840b5306a8cf 100644
> >> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> >> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> >> @@ -13,6 +13,8 @@ properties:
> >>    compatible:
> >>      enum:
> >>        - ti,tmp102
> >> +      - ti,tmp110
> >> +      - ti,tmp113
> >
> >The driver has no match data and no compatible based decisions added in
> >your patch. Why is a fallback to tmp102 not suitable?
> >
> Thanks for the review, it is now more clear to me. You are right, the
> fallback to tmp102 can be used. My intentions were to be able to make it
> clear in the dts which is the real used sensor on the board but this can
> be achieved via the node name (or label). 

No, node name or label is not how you do that. compatible is the right 
way.

