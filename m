Return-Path: <linux-kernel+bounces-775543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D66B2C051
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43F87ACCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20A6326D72;
	Tue, 19 Aug 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BT9BmTkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5130F813
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602844; cv=none; b=HXt1lJBvw3enyuQTJdTyOSbFfo5V+3mK/lTVo+KyQdYBpQ6k1zYR3FBYhxOvjVjybIeu4pRHNI/gDmB7MQ5tgB8eiG3els4DM7agwpuL5Uzj5e9mzqkBSic2da2iiWGIAXt02c3A/3ISPo1Ov4hNyMX159JeObG311tMjMrC4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602844; c=relaxed/simple;
	bh=5sIe0DDvbDhL3Vz6/3qTnXE3GbYfD8GB9O32jPTVG0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHP9NWX/3SDMD9uZFvJRCzdxaCddebQkj+K6UerPLSaZGry85pUyGI+qvCfb4iO90lmQ5i00m/Lpsm1Lr/+nBLxnG4v+BLi0OCd6MlqEve9U0h1TOWjZE8hyNsAy+syhsnhTMKLLChYXNGwRlex71BRWwCDSDbGJ49hFIAKmMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BT9BmTkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E14FC116B1;
	Tue, 19 Aug 2025 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755602843;
	bh=5sIe0DDvbDhL3Vz6/3qTnXE3GbYfD8GB9O32jPTVG0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BT9BmTkPDO+4lcDxUy46J8iwBTB2tWR1+IeUbciGv8j2d9Yo+W4Mo5BT8y1duFhaG
	 MDBm+RnEe82p/x/QAwY9MFvEaBBzmrazZ4WgJa2FnvFdhWfeMObp65XUR2syWKYT2Z
	 stQPdmWYMJxxSQ4BfOUSpmLUFUaaGXHlW5oXLQmc=
Date: Tue, 19 Aug 2025 13:27:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] samples/kobject: constify 'struct foo_attribute'
Message-ID: <2025081941-thirstily-comfy-05b1@gregkh>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-6-0d973ff46afc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-6-0d973ff46afc@weissschuh.net>

On Mon, Aug 11, 2025 at 11:14:32AM +0200, Thomas Weiﬂschuh wrote:
> Showcase and test the new 'struct attribute' constification facilities.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  samples/kobject/kset-example.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
> index 1aac595ed9498b30448485a60d9376cb5b5ea1d3..98aac6940f51f3312b44083a9d4ffe7afed1dba7 100644
> --- a/samples/kobject/kset-example.c
> +++ b/samples/kobject/kset-example.c
> @@ -37,10 +37,11 @@ struct foo_obj {
>  /* a custom attribute that works just for a struct foo_obj. */
>  struct foo_attribute {
>  	struct attribute attr;
> -	ssize_t (*show)(struct foo_obj *foo, struct foo_attribute *attr, char *buf);
> -	ssize_t (*store)(struct foo_obj *foo, struct foo_attribute *attr, const char *buf, size_t count);
> +	ssize_t (*show)(struct foo_obj *foo, const struct foo_attribute *attr, char *buf);
> +	ssize_t (*store)(struct foo_obj *foo, const struct foo_attribute *attr,
> +			 const char *buf, size_t count);
>  };
> -#define to_foo_attr(x) container_of(x, struct foo_attribute, attr)
> +#define to_foo_attr(x) container_of_const(x, struct foo_attribute, attr)
>  
>  /*
>   * The default show function that must be passed to sysfs.  This will be
> @@ -53,7 +54,7 @@ static ssize_t foo_attr_show(struct kobject *kobj,
>  			     struct attribute *attr,
>  			     char *buf)
>  {
> -	struct foo_attribute *attribute;
> +	const struct foo_attribute *attribute;
>  	struct foo_obj *foo;
>  
>  	attribute = to_foo_attr(attr);
> @@ -73,7 +74,7 @@ static ssize_t foo_attr_store(struct kobject *kobj,
>  			      struct attribute *attr,
>  			      const char *buf, size_t len)
>  {
> -	struct foo_attribute *attribute;
> +	const struct foo_attribute *attribute;
>  	struct foo_obj *foo;
>  
>  	attribute = to_foo_attr(attr);
> @@ -109,13 +110,13 @@ static void foo_release(struct kobject *kobj)
>  /*
>   * The "foo" file where the .foo variable is read from and written to.
>   */
> -static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
> +static ssize_t foo_show(struct foo_obj *foo_obj, const struct foo_attribute *attr,
>  			char *buf)
>  {
>  	return sysfs_emit(buf, "%d\n", foo_obj->foo);
>  }
>  
> -static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
> +static ssize_t foo_store(struct foo_obj *foo_obj, const struct foo_attribute *attr,
>  			 const char *buf, size_t count)
>  {
>  	int ret;
> @@ -128,14 +129,14 @@ static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  }
>  
>  /* Sysfs attributes cannot be world-writable. */
> -static struct foo_attribute foo_attribute =
> +static const struct foo_attribute foo_attribute =
>  	__ATTR(foo, 0664, foo_show, foo_store);
>  
>  /*
>   * More complex function where we determine which variable is being accessed by
>   * looking at the attribute for the "baz" and "bar" files.
>   */
> -static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
> +static ssize_t b_show(struct foo_obj *foo_obj, const struct foo_attribute *attr,
>  		      char *buf)
>  {
>  	int var;
> @@ -147,7 +148,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  	return sysfs_emit(buf, "%d\n", var);
>  }
>  
> -static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
> +static ssize_t b_store(struct foo_obj *foo_obj, const struct foo_attribute *attr,
>  		       const char *buf, size_t count)
>  {
>  	int var, ret;
> @@ -163,16 +164,16 @@ static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  	return count;
>  }
>  
> -static struct foo_attribute baz_attribute =
> +static const struct foo_attribute baz_attribute =
>  	__ATTR(baz, 0664, b_show, b_store);

We really should make this ATTR_RW() one of these days.

> -static struct foo_attribute bar_attribute =
> +static const struct foo_attribute bar_attribute =
>  	__ATTR(bar, 0664, b_show, b_store);

This one too.

Actually almost all existing users of __ATTR() should be fixed up so we
can just remove that (special modes can use the __ATTR_*_MODE() macro)

But that's separate from this series, sorry for the noise.

greg k-h

