Return-Path: <linux-kernel+bounces-881767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA01C28E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A693B0275
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1012C21CB;
	Sun,  2 Nov 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fwI58T5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tx54dOdu"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F82C15A6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762082745; cv=none; b=dj748LOW+auqwzA+m6Yk7OnV5gGxzHI+BpiQKhyoWzfcYgkBozTDAbwvaDNepWLx6jCD5NVatVY7RXcM/UqKFRB5GcXE584uUbWvl+7+RaH17DN8+XEeua8uK9lhBot2g0EcSdRmuX71iqm5jqwyefKDjqDwuqPepCQ5SHfAtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762082745; c=relaxed/simple;
	bh=XvRRFIyXMVgoW0JPn7Re0Z9W5NmAex+lHucp9Kd3mJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMywgV65drWPewz1EDiR6NFX71yio6j6M0c52s53Iug+xgwYtCWu1s17WFNbrfRX9x2MxwyScc9PVCm+vPaTHG8K6Ys74FxCVRxrxs9WArNylpWEq1Z+iFwv591Mnvh9R/eHBVb97zcqVOztKCQTlU7JhIz8K7/VexExZPGCIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fwI58T5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tx54dOdu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A74B4EC02EF;
	Sun,  2 Nov 2025 06:25:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 02 Nov 2025 06:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762082741; x=1762169141; bh=eMgNMqqqsn
	q9Z9xVXUVGiUsUCvTB6a5jHhl12aqMYsY=; b=fwI58T5kC21xw28hnOM2bDBfP9
	i4fhJQiWRL9gmdgsfc1I76B1YN0NvGhj5K3bds0ec9988rtSyLEKfSIxTkQK19hO
	aAZ1//vH8V61T3blxCC7murYstNsQFjGl2wgztbjSRqaieBolPUoba252cg/YwyD
	2DU9cnGdT7k4NCVAPFZmbnOGc0IvrE5Ug/c1lzPBPJfomw4ITP2v6qZoRpa7Wt5l
	IXG1eKzHbQoqot2Xc1hS1TUk3aBVFxvGOxChAkAwNKEr+TymSzVg1/C8f5BEsbFO
	fHVA2QyPiF8YKp+Bl8/qndav2viWBSOzG070eAAVBRebRE5SH6DdJ4fM0j/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762082741; x=1762169141; bh=eMgNMqqqsnq9Z9xVXUVGiUsUCvTB6a5jHhl
	12aqMYsY=; b=tx54dOduKRGVmqPcP1CamcSbZlfGoZfjDTaYVLd/Pt05WLoE9Ds
	TBLJnbCZwPNavtBZugjKW8txjgwmVoy3cqk9yfGf0nuANo1dYDnZ8U2zEdqxR5f5
	Aum/58h2F2jra37bfrXvy39bm3DqSVXK16kqqO94MseZlRXvoXaAln14xszpP3Bn
	NHrJkzKA3QzZtlC4ck90R+2m20eK89p9nfQmCPF23qF/yIfyiBDY2rOCgpDTODdV
	HKbOghY8sd9/lSOI4hYWFeWYh3VWJhuhPQZOuqKZBiA4wJPJwO5bl/3zxI/3t6so
	KnWcnZd83TSVM4XcO1ueIbmDaMj045r0HMQ==
X-ME-Sender: <xms:tT8HaXU_a5ED4WGX0x-iDq2BzaVpMG_pFbC-ln8f0rKrcbseS4NR5w>
    <xme:tT8HaSIDPW4l1jsYpNZd_q5R2GPrk_Fd1bS5kPWpvfsHDUwuBkC0jBNikm4HEUAF_
    jGzidqy58k-RgkM5JRSHDSLye9962AVuCaf584PjWiooLhqMg>
X-ME-Received: <xmr:tT8HaXC2QKeTetomvDHJnxEn2NF16AZ_n5n9PRpK4n7r6HhLkBaxucJ00CKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrtggrtggrgiduieesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgrhgvhigsuhhsqdguvghvsehlihhsthhsrdhlihhnrghrohdr
    ohhrghdprhgtphhtthhopehvshgvohhkrghkthhushgrhhejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tT8HaScDQ7cyA2QizXH-dAySO6kdKKhTPlbGuaomgEWCBvC8HVaNpA>
    <xmx:tT8HaW2R0XdPQIXl9y_ap2zPlJR_hTdrmtR2NPYNBKfDpFwLX3RB7g>
    <xmx:tT8HaZiPAPXgR2GqBf1vJzHTJ0q8GlI8P3Ciwg6Fa34huqvTnneGRA>
    <xmx:tT8HafmvZsssvm0bMnWq3OaOoL9k2Awhzp4npjITxOdn8WIjmxr0hg>
    <xmx:tT8HaTIqTDsasSZwnCsrwdGK5VjmDUn8kFa27q7JOgLi9NPeGUCN4EPO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 06:25:40 -0500 (EST)
Date: Sun, 2 Nov 2025 20:25:36 +0900
From: Greg KH <greg@kroah.com>
To: zntsproj <vacacax16@gmail.com>
Cc: linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: Re: [greybus-dev] [PATCH v3] Fix tiny typo in firmware-management
 docs
Message-ID: <2025110200-announcer-handful-fc5d@gregkh>
References: <20251101075247.11415-1-vseokaktusah7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101075247.11415-1-vseokaktusah7@gmail.com>

On Sat, Nov 01, 2025 at 10:52:47AM +0300, zntsproj wrote:
> Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
> ---
>  .../staging/greybus/Documentation/firmware/firmware-management  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/Documentation/firmware/firmware-management b/drivers/staging/greybus/Documentation/firmware/firmware-management
> index 7918257e5..393455557 100644
> --- a/drivers/staging/greybus/Documentation/firmware/firmware-management
> +++ b/drivers/staging/greybus/Documentation/firmware/firmware-management
> @@ -193,7 +193,7 @@ Identifying the Character Device
>  
>  There can be multiple devices present in /dev/ directory with name
>  gb-authenticate-N and user first needs to identify the character device used for
> -authentication a of particular interface.
> +authentication of a particular interface.
>  
>  The Authentication core creates a device of class 'gb_authenticate', which shall
>  be used by the user to identify the right character device for it. The class
> -- 
> 2.51.2
> 
> _______________________________________________
> greybus-dev mailing list -- greybus-dev@lists.linaro.org
> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for a
  description of how to do this so that Greg has a chance to apply these
  correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

