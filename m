Return-Path: <linux-kernel+bounces-775533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70EB2C030
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83ED1BC5AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EBD322DA6;
	Tue, 19 Aug 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvqUa06J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A231064E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602648; cv=none; b=GnMNt9I5tq6t9wpMG1RiZ76gJIA6tVw4lEVg3yCtKfBfXZDmFsFgXa7tgDQaZUZacus/pBGvDAxSd9P8KHAQxIRMoYhXZoPh5a9DehD9LFG4a2DMPRTSOq76Zr52LPsjy9uNEn0r4QwI7RLvzHuMZQ4SZuTk2pXFyrIK5HY/Mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602648; c=relaxed/simple;
	bh=RT0cQ/dQgXnrH3FkMa/BlZ78LbiVhSisiRWR5VBlafg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvXSEAF2NxrpbBA5A12415QVPref/n/u4oGhZOGbR6GswvowfiILdz7AdLye+fMjpo+saCIO3fBsgKtkIRlgUzenAKZ/U5DP+CjBQ4WAJgx6BzShMsC3vf8I4loMoAwPBY8U+P3GzfIAf94DqJLnFR35pgzi6I/s1gnzgui4B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvqUa06J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED5C4CEF1;
	Tue, 19 Aug 2025 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755602647;
	bh=RT0cQ/dQgXnrH3FkMa/BlZ78LbiVhSisiRWR5VBlafg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvqUa06JVXikST4YeP4M4oLpzQrlJGTu36amnI/bAFEYTCHFbCuWs2RfMViS8iu1B
	 5Mb3dr+Smjrcv/SkixIXvdsMLB45RF7Kp8jguo+wof6j5yTsBs1+NyUzP18vbiK847
	 DTe5+nYLW+p3ZdaV9zcvh/SzTA4eafUkP+QIZcOE=
Date: Tue, 19 Aug 2025 13:24:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] samples/kobject: add is_visible() callback to
 attribute group
Message-ID: <2025081931-deprive-overtime-b353@gregkh>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-5-0d973ff46afc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-5-0d973ff46afc@weissschuh.net>

On Mon, Aug 11, 2025 at 11:14:31AM +0200, Thomas Weiﬂschuh wrote:
> There was no example for the is_visible() callback so far.
> 
> It will also become an example and test for the constification of
> 'struct attribute' later.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  samples/kobject/kset-example.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
> index 579ce150217c6e613887e32a08206573543b3091..1aac595ed9498b30448485a60d9376cb5b5ea1d3 100644
> --- a/samples/kobject/kset-example.c
> +++ b/samples/kobject/kset-example.c
> @@ -178,7 +178,22 @@ static struct attribute *foo_default_attrs[] = {
>  	&bar_attribute.attr,
>  	NULL,	/* need to NULL terminate the list of attributes */
>  };
> -ATTRIBUTE_GROUPS(foo_default);
> +
> +static umode_t foo_default_attrs_is_visible(struct kobject *kobj,
> +					    struct attribute *attr,
> +					    int n)
> +{
> +	/* Hide attributes with the same name as the kobject. */
> +	if (strcmp(kobject_name(kobj), attr->name) == 0)
> +		return 0;
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group foo_default_group = {
> +	.attrs		= foo_default_attrs,
> +	.is_visible	= foo_default_attrs_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(foo_default);

Wait, why?  Shouldn't ATTRIBUTE_GROUPS() still work here?  No one should
have to call __ATTRIBUTE_GROUPS() in their code, that's just going to be
too messy over time.

thanks

greg k-h

