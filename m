Return-Path: <linux-kernel+bounces-898490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3BC55656
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1C53B6E12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30B1F181F;
	Thu, 13 Nov 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTy+beqK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8E3B186
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999757; cv=none; b=F4oeROlPu45MYGAa8KTrAjvBNYDMGw8v+OiDdEFR/orgl6K31RWF6nYXKSrteeU79BsNgoP1HlBa45To0dz+e4xg9oOZ7pnj2CNorHBeEgJNYl6oVzq8gyWVYE5/boRe4yNHhWmQvTnE2PK6xY5pK0SHmcLYZzpW1sxF56DXBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999757; c=relaxed/simple;
	bh=6UwvIGsRbrpFaKVD6/b6P6NuYJ3KfTLF6Du4cbGN6Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSVF/sLmWFF1YMsg/2rYIRhHr0sXJ98n9b61PYBPQ+sxNpje1cGYaJowqmd7xEGTqvTTbvUkuTE2wv3ZhXzxVI3UdQowsal0LfHr2nAcgZBpwOykU3vc6RQPx6oX0GpaIMo5iZm7o/9gF/H3E4QG6g8KXucyYYzoVOGrvEzaA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTy+beqK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72dc0c15abso39232666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762999753; x=1763604553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YilcDuhj1dhziVhER+kb8IKURkf5X7d7kISKxPO1dD4=;
        b=PTy+beqK+BHaTpw4dgbyvx4F5AGsL/x/Wz+DmfUuBpHIZ4tjV8mB/gR/MH7aS/FkPV
         5cJuKOHvyu7nKM85x3q9svHZMOgqLCKVBqsJS51Xpy0cVxc1t7ehDoc17SgRDBoHZlAq
         Ozfdljg0K7NL8PbqUYhvA7vOyykUTNcStb3V2UXnu70kdsxynCoZvCb6uEHmgqtF+5d6
         iNVPXvHO1mssIzmjhHAUizkx4DQ007jh/4U39pFcWdD4Ja7JWPbl7hgXsnlmjpJn3aBj
         bYmV2mkZVTr4uWfFbJxTo8sb4OqYrRhXQaeDYxcivcPx6a9R/u7gouYbWBofmi7RtxIq
         yO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999753; x=1763604553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YilcDuhj1dhziVhER+kb8IKURkf5X7d7kISKxPO1dD4=;
        b=lBosYWBRvpgN2UBFJ9zKvtX/CLyr2jo/rcjyhYr2vM58shPxiOwYYedDGOB2lYcAWv
         supWLl7edwu7mKScX5UyvfB6i7MAFflAtK8gGVkuYQeftf9rJ6swSFK/A+zzTsjPdOfQ
         YeYM6+gAFZuoj7c2hTovp3M7IFvhjgj1qz19v2nLOYgq+PABT9gViOtScmv0IYSZ9cqN
         EG6lHe5fU2Pur4qStPIoWfBBkLVjekT68U1IP21SftqpJio0eQRhtO9qNK+2GysLxkO8
         iHhRy06UaJlAl6JFMarV/bKvSSejWZhsNJhw4ybTXtBz8G75HHsNTKgRNt/ncYtX7HjW
         KGuw==
X-Forwarded-Encrypted: i=1; AJvYcCWK2hvWSfjOvD/Me++vQJR57pPiWRO0wNahBD+w4qTyXLids1pJiUwHcYD74nTkpOvjLL133Ao0lB6Y5F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDTrUGy+fCcMWNLdbtO+b6v377XQF0QiG2WOrosWw18U5X7+G
	pQvTvnBwL+FjA6gEzI64VTjahRu0mUgflhIwfeaVG7f6U2NeRUYYeCYl
X-Gm-Gg: ASbGncvgHAqNzNmyRaviRXYjNR7EB+aJBRUaoBvm5eXOdjArOf5L6USgDQW7+XCP8nI
	fwrclXiU0fbxqU3lyOfcCWZLNxajaploP6R8fFWY7n0auU5omH8Mgp79HSLwoh7jWJcAkCJDyl/
	Cg4Lw2cnfnpreLXNuhUPYN2+L/NmuBd8zQ0Rqvr1DzOS2OGtGkt4qgG1jpXQq6UDm3+dOVFEG3c
	APNLPVSY0XWfC/RsMkvmiZOgSRcG4zwi4HeGGXEK4FZTaHyv4zqTJerBY9GWoIeLiR+MSa5X60O
	CpTetT0ylYc1s65Y1wkoHsJC93NHQvsMx0WPyZXU2+eFiwCZyPt/8vmSq0u0eWTk7CeCa/JyGfZ
	ru72nbepFYMLFroWXkGjpNSV/fXbOb7BGm1FrXwDnJLlV3Q+TeAJEWaBrE3Hab/P640NDtKvQUZ
	vq0nAan6aIzcYjpbDt5lUDsmbNv8MwyhJG6joKMq9FWlrpCQ==
X-Google-Smtp-Source: AGHT+IFxoYa5KI4RfrUVTTMhZzXg4lGOX/gv1esso0Q+isWJ+ieIFGJgHziAmQfL7z67Pf8gUo2nwQ==
X-Received: by 2002:a17:907:e895:b0:b5f:c2f6:a172 with SMTP id a640c23a62f3a-b7331a70378mr520934766b.30.1762999753041;
        Wed, 12 Nov 2025 18:09:13 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad41e5sm54885666b.19.2025.11.12.18.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:09:12 -0800 (PST)
Date: Thu, 13 Nov 2025 03:08:47 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: jayxu1990@gmail.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, rdlee.upstream@gmail.com, 
	avnerkhan@utexas.edu
Subject: Re: [PATCH] fs: optimize chown_common by skipping unnecessary
 ownership changes
Message-ID: <uh2mcjliqvhew2myuvi4hyvpwv5a7bnnzqlptfpwq5gguiskad@ciafu7tfwr4h>
References: <20251113013449.3874650-1-jayxu1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113013449.3874650-1-jayxu1990@gmail.com>

On Thu, Nov 13, 2025 at 09:34:49AM +0800, jayxu1990@gmail.com wrote:
> From: Jay Xu <jayxu1990@gmail.com>
> 
> Add early return optimization to chown_common() when the requested
> uid/gid already matches the current inode ownership. This avoids
> calling notify_change() and associated filesystem operations when
> no actual change is needed.
> 

If this is useful in practice, then so is probably chmod.

> The check is performed after acquiring the inode lock to ensure
> atomicity and uses the kernel's uid_eq()/gid_eq() functions for
> proper comparison.
> 
> This optimization provides several benefits:
> - Reduces unnecessary filesystem metadata updates and journal writes
> - Prevents redundant storage I/O when files are on persistent storage
> - Improves performance for recursive chown operations that encounter
>   files with already-correct ownership
> - Avoids invoking security hooks and filesystem-specific setattr
>   operations when no change is required

The last bit is a breaking change in behavior though. For example right
now invoking chown 0:0 /bin as an unprivileged user fails. It will succeed
with your patch.

iow you can't avoid any of the security checks.

However, if there are real workloads which chown/chmod to the current
value already, perhaps it would make sense for the routine to track if
anything changed and if not to avoid dirtying the inode, which still
might save on I/O.

> 
> Signed-off-by: Jay Xu <jayxu1990@gmail.com>
> ---
>  fs/open.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 3d64372ecc67..82bde70c6c08 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -761,6 +761,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	struct iattr newattrs;
>  	kuid_t uid;
>  	kgid_t gid;
> +	bool needs_update = false;
>  
>  	uid = make_kuid(current_user_ns(), user);
>  	gid = make_kgid(current_user_ns(), group);
> @@ -779,6 +780,17 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	error = inode_lock_killable(inode);
>  	if (error)
>  		return error;
> +
> +	/* Check if ownership actually needs to change */
> +	if ((newattrs.ia_valid & ATTR_UID) && !uid_eq(inode->i_uid, uid))
> +		needs_update = true;
> +	if ((newattrs.ia_valid & ATTR_GID) && !gid_eq(inode->i_gid, gid))
> +		needs_update = true;
> +
> +	if (!needs_update) {
> +		inode_unlock(inode);
> +		return 0;
> +	}
>  	if (!S_ISDIR(inode->i_mode))
>  		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
>  				     setattr_should_drop_sgid(idmap, inode);
> -- 
> 2.34.1
> 

