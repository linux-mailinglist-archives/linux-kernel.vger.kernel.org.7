Return-Path: <linux-kernel+bounces-796229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE80B3FD92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262534E2C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BC42765C1;
	Tue,  2 Sep 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TG1LNgkq"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2527EFEF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811837; cv=none; b=ssNRExUlqPbY9Ad4TeIVE4nwn2LcLpZ1+4SNE4/qPSxnCSfFRBrwH9Qxh154o5gt0yRNli5BtvQ44rUwRWHt6DuU7zC3lSmeM90chUBQ/TMboEYXXrPiF1ATKiPL4t2OFK5v58q/aArBA8kyucORfivfA1G8Gc6YQZvdIfBF3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811837; c=relaxed/simple;
	bh=tFz8mxWmtvp+OLRSVyZYdPXZ40EOLiMevSfJIuTSZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsY1YinOZFgnlf92ep7a35n/oRVr7WWoWY7eDN7zhoi6qQRiuZrYNFpbroH1zcxbH4j2rO9rfc+CktL5ZoIeFo5ZyyMeaWqb2sJJ1NbuNCjwxooP9Hc+AwakpaELxhhPe/pTmToCqBWPZ58ChhzeTma/iso1kJ6usqkPZVtXD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TG1LNgkq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso2394135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756811834; x=1757416634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkjdJ99tSVQ09kKrtq0hv3IjTswl5kKM4uWkHH+xt00=;
        b=TG1LNgkqLtq9cIfMg2TppFSf7wDvWXZURS7bUn1zsAXXeR3nyDMz/jckkqyHVzGlj2
         EpJh0wN5eHePSXUV65F2EidnCCVvx7fofkNmL+j1uvsxbLWNXvz0NO6TDjBNB7QVAN6m
         y/9vDaHTAWhBLHOXcqEfg6DN0rle7qcoOMpi4wouoGT9Z+O8S+akwPqQxDsaZdC9+Dkj
         Hl37AkSXcMqFFZw5jSm2XiaDsPFdkUblK1haJtxCr4SA41/XEXeNihBa72aplEgySu0x
         dK42F8wLBJQ7zI7IArBWsUBq5d2csaCvesL5/GmrIA9SiKis+wpqFamZxMNpuuij/wQ6
         pgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811834; x=1757416634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkjdJ99tSVQ09kKrtq0hv3IjTswl5kKM4uWkHH+xt00=;
        b=o3Tiq+maqLy6L7MYpoci3IogZ2N85AMIxCkS1dGkgoGiLO+FxCERpt6eBD9OJM/lOd
         rLaFg511EWoSA8lmuzcfAp7coC29RNky1U/AbFsLV/bjqFwEMb+hTQoNikmYFSDQ+iDP
         SxPWJHj8LGFC4Q3D5G3L3edRRxokHVtgVqinGOA5nCoPwn9R2dM3umdNijK2QYlHcSXC
         BqDmuZ0yr1XabR+gz+fYJCr3jlwbrz3ygMKcmqcHbMOp5swB6hndECh2OPSPlHbI+nmY
         PDagzODVloUzCR7RMIR20lixSM4pcLy9Xph06oEWZv+M+kYCsGKUus5dyNkaOJPFPACC
         eXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjoQTWlnL5GDX9wnzWxcaWGq00t/qMKWUaqHO4q9ccP4+rfc/zFo6AhDuzRTSOedjRhbjEq/GDZWhdXZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAXNRoXhxaTkGWdoEmKp3WjTOHcK8iQhUIWvAASSZ9KwbveTm
	FlQ7Pza/Xoz1BgvJ98CLnjQDNjF+niMufW9YOp8he0x9ZYN+k0WMkJMYKIRVuM11sjDVqwjdVSF
	YFfL7
X-Gm-Gg: ASbGncs7hoZXY7dp+M34SUjxqJoGab2J3tPskSo/92tQDfVjs06BQzlX/xaiUx7R8bV
	mHueIJv6D13inx2KcCK5cZNkGGTvqSHH4BfwfJwJR8xoTjnUX8epBQ+eUFk1BrO0pTPG2zfLc6a
	LkVG7WbvzfyfdcWfh40lkyjvHJAyNzzskBGfwWCZLrnSUwfRbfcAxE2UL+l+xPwfrdLX9vl9pXs
	LjYUX80Ke4G6OqJJ1L5g9DEZtDp2rJXoAxPal/jfZumZgJiMLmtn8SS07UolfyjUr9tHwn/rz2D
	QRhnuxEzafNjEid+c9luTt+Ss4FCSwL20k0GXjKSDTFtp8nU0cInD1G6LEyT8KswU4Eb/i7+UUq
	z3oB+Qbd2PA5Tg/2PF/DvmjeIRyV+uI22dFvfkDkPu34=
X-Google-Smtp-Source: AGHT+IHz6YILuOaZ0SJzkFmlUROnxTGIZnMil2cOBLxZw94mqhQOg5dIe1n/6BlQbAypfFTe3xtbTw==
X-Received: by 2002:a05:6000:1ac8:b0:3cd:5405:16e7 with SMTP id ffacd0b85a97d-3d1de4bc31dmr8130862f8f.29.1756811834120;
        Tue, 02 Sep 2025 04:17:14 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm207225375e9.20.2025.09.02.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:17:13 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:17:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <tl6b6chfawtykzrxlmysn6ev7mq7gm764rnlsag7pfme7vhpof@lbwqooaybqmr>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
 <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jme3b5n5ad5ko2pk"
Content-Disposition: inline
In-Reply-To: <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>


--jme3b5n5ad5ko2pk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 09:56:34AM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> If the increase in size is not a problem, then something like this
> works fine (unless there is a problem with moving those two members
> at the end of cgroup_root?):

Please don't forget to tackle cgroup_root allocators. IIUC, this move
towards the end shifts the burden to them.

There's only the rcu_head we care about.

(You seem to be well versed with flex arrays, I was wondering if
something like this could be rearranged to make it work (assuming the
union is at the end of its containers):

	union {
		struct cgroup *ancestors[];
		struct {
			struct cgroup *_root_ancestor;
			struct cgroup *_low_ancestors[];
		};
	};
)

Thanks,
Michal

--jme3b5n5ad5ko2pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLbSLRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiIAwD/b00l+aVBPRUgP1zHehty
uF0kty/XKqKmicCz61ldtxcA/1riA1X/290Fr8aUbMO/YyrMIhkgpxSWHh+JPrSl
/WQC
=0maq
-----END PGP SIGNATURE-----

--jme3b5n5ad5ko2pk--

