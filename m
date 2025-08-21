Return-Path: <linux-kernel+bounces-780775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A5B3093F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF99716FB24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22B2E11C9;
	Thu, 21 Aug 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3D5ZTQv"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4325C6EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815617; cv=none; b=ReC/OnhrBiFNgk6wcSBYOsmNHsM/CYtOgGsvC80/rv5iUCnI6qH7ovDghIR4kVCZMoPwnxWBi+BW1Q6ZhUrjVY42qRMavINdrjPVIwZXlA+TE5XePhKE7eIB82bb7NO69y8PWSEefoTebdIZh5Z9MS5mMZgDuW/MhPBC9M0m6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815617; c=relaxed/simple;
	bh=SnZKxn3/SMbjs4aOcSRemCcoa3UrhMIbtGqm7h9md8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt9adtVPpt9oHQDMaZlLL6BQ6PwjCnIBbSVbO1mvWj5VqJSUQIC4RckG1ckqD8pP6ME9VtezWeytuYmcTUuPPh+ezUroGzNPBJ5ZOfxZ3ZKLAb3QqBoy0c0J60KXnzGrPdd5QW4zjFa32fMrSmMrcKcNJXH+oEBtsPGJsk2S2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3D5ZTQv; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e669190664so12181875ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755815615; x=1756420415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnZKxn3/SMbjs4aOcSRemCcoa3UrhMIbtGqm7h9md8s=;
        b=J3D5ZTQv8fb6X0YUBgcYcQASaIY13cXvtB30Opm6bQD8V59DGv5wD1QqXbZ4SLdvTa
         PeWoCR3unJScqdN6+zmE4tDbDyMXuzu0QNZQWmkxaK1k4Mj6zCLDSrxD4DDRLs2eIv3Y
         qqPz8UdFNEflfuFFkfRkIMb6S543crBj+Ft4Ha2eefkPZJ7bJknVgOfYktl7o/3+Oh86
         /kd3vwSKZiItMC8iYSqu8hgigioY1kLNW4m4LjI0a+H5ygvIUhMDPKDajhRaCcSTMq5V
         TxDwyW/Vzk2at3zL9hnZzs95vsaiVgqNn2D+XEs0bhw82aFZC2PqhYP9yfxEOKB5+OKX
         ILyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755815615; x=1756420415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnZKxn3/SMbjs4aOcSRemCcoa3UrhMIbtGqm7h9md8s=;
        b=C/x/5wIIxgm8ksfizScTqHg4+5WuV7FbLK8cgAvW/HscIDS5O8yk9z3Hrk2d7dsOyq
         us65/G2kcJnzDiHoMeVQXzzp/pmlBKKxNMSx+pk3sr37kv4TjAQVmTE3/SDSkoJbAGnS
         uFJsyZUMedYDiujY+bDhDdGlUksnLgkLI39zpM6PmgOaNnXVfgkufqircD1v2fg5M/HH
         HqKVjmVf0qbFLAyA2hJ0JmKByxxvRGLxDXITmEm0Xi+vYgTd+8xaNTS0aboGSAVgaGcE
         2fMqIPT4+yFH8JBhEApfNndBo5IudndqiXzHhe0eRPBWk1Dp0ElOfUWyG4LAw47pnOu8
         d9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU0iPyFosfURPyGT/4ERLOzdfQaC9+OVz9GKmappi7PX2JsDpye66x8d0h7/2vCiRfxRYNtFFGxhE/fCsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycF72uCynlDhSactfyvjls9pBSLgRF61KUt7ceGnIFXla0hMYM
	LIpRJMsDJq3la5gKGRcqQIEYlUb1KULTHLkizo3drdRYjkdUFhMjimUzw+stBVV2KQ==
X-Gm-Gg: ASbGncs8iA9ORYIvZJF1mWLkMAd5GSYPz7U+1ZZubuWywFWivOHn66zkdkJhxRcD5QG
	p8NmH8qCNfO4CIwE8EJYpJui0qi375ZlmwmuYUMB93Ez9DkfM5zi2+2aFOyFjD0WyAqHLAokObl
	H5IB70nGjnej4JnznME84qhD+5QdVZxYyKw3oo5HIVBXoWPk+CcqHtf8KkoDBFVyNbt3i6JKJtp
	aJbLUywH/JBwIInyQp+qGq54gpqmYhPeBEArNm/X4+d0HLnC1NTxH7ZGDNB6rbQnQ7e6fwBw1sX
	WoIP+bnzepAFNjr9k3I91p+6XGWHhQ6d7VNf1fRrwqdpDpxXDzq3gyDSS+sCfspToRw/VPtHtu+
	xVI4dupY6fh1/2LfCJOAtQuKdx+9UO6tRICrWYnWynuhiYOJaMCEnnFklDKzz/7QCQw==
X-Google-Smtp-Source: AGHT+IEGzbbJOOBIn6TC2Tb+WI7UDDv9xLsePcm3E8uJTuF+vAY06pBGbAB+hdY1ZUNYILsPBsWGow==
X-Received: by 2002:a92:cd88:0:b0:3e5:4816:8bca with SMTP id e9e14a558f8ab-3e921a5d7a2mr20072225ab.12.1755815615067;
        Thu, 21 Aug 2025 15:33:35 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6a6c3bsm80502205ab.41.2025.08.21.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:33:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 22:33:32 +0000
From: Neill Kapron <nkapron@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	kernel-team@android.com, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: enable per-file labeling for functionfs
Message-ID: <aKeevPJ0TDcp1T8W@google.com>
References: <20250820212302.2325779-1-nkapron@google.com>
 <CAEjxPJ4Vi9rXXkvPUoS-tjHks_6oevdkhrjvSeX_Rh5VV5gBBw@mail.gmail.com>
 <CAEjxPJ6iFrfVxbRM71b9G0+59L+vxNiJ1mpeXSGwuG_n+D15Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ6iFrfVxbRM71b9G0+59L+vxNiJ1mpeXSGwuG_n+D15Lw@mail.gmail.com>

On Thu, Aug 21, 2025 at 09:03:49AM -0400, Stephen Smalley wrote:
> On Thu, Aug 21, 2025 at 8:59 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Did you confirm that functionfs is safe wrt genfscon-based and
> > userspace labeling, as per:
> > https://github.com/SELinuxProject/selinux-kernel/issues/2

Yes, I believe this is safe - FunctionFS is a filesystem which
exclusively exists in memory. The kernel creates an EP0 file to which
userspace writes usb endpoint descriptors to, and the kernel
sequentially creates the endpoint files for each descriptor.
.create/.link/.rename methods are not supported for the root directory
or any of the file inodes. So userspace can control the number of files
created in this directory, but does not have control of their naming or
anything else.

In Android, we further restrict permissions to the directory and control
endpoint EP0 to specific system processes. Our goal with this patch is
to maintain this restriction, while providing more permissive labels to
the endpoints created by the system process.

> >
> > Also as per that longstanding open issue, we'd welcome patches to
> > generalize the current hardcoded list of filesystem types to
> > instead lookup the filesystem type in the policy to see if it should
> > support genfscon and/or userspace labeling.
>

Unfortunately, that is outside my expertise at this time and I don't
have a solid understanding of how this would be accomplished.

> Also, do we need a new policycap to conditionally enable this new
> labeling behavior to avoid any regressions?
> See the corresponding checks for cgroup labeling and
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#adding-a-new-selinux-policy-capability

Thanks, I will send a V2 which adds a new policycap for this.

