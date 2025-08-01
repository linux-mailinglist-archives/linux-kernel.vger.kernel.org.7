Return-Path: <linux-kernel+bounces-753622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06FB1855F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22FD188EAA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E928BAB3;
	Fri,  1 Aug 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhP5Fdtn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5026B756
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064198; cv=none; b=qtvMXa7UpV8HmhyNzLDG84LUBkQxRb2AbDMcREyNFr/PaTY+qWnZqLWn4DHgq3X6KxnRDy91i7rC6YGvlxtvoo1oEbXWR1p4LG8ffAkTLXvdZjOyF2P5zv+iyFywk4lBWORhcwgVY3PjRjQx1OL4cT5dMFMZdp9nGoT3+puFGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064198; c=relaxed/simple;
	bh=kTBVDH2a7C5AaUhSLvbnLRucMiqIC9KeXaHey8lqNgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnmaBo66bOKVQut+7t4uwpb9XUFshtDeobpZ+cFbP6x7Gvly4ZkED0/OmHv/QhAP6PBA0ucXJ1qf1dzNTFkci4PcnLyjeMEC70Sg9d21DZAY3sCt6FGQbHk+wI+RofDRdAUTFKWW+xXq9Mx9aR3B+cmhg+IL2QorpIS2SirL3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhP5Fdtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754064195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vMRSYj4Eiotram2sHuDHJExcsIVaBr8JOLhPuPHdhRI=;
	b=KhP5FdtnkISMKLJMniOfU5pqrAkLchPgZmYtHn/kpuhj1tVqlv3gqkVxnJ3JwpmulZgNPW
	SV3T8ouIo4rFhlJbCFAOeISAzUNvNrjiIAWsJbIvgsRJ3V5IIwmajQKjHtmu4JT4Us7h2+
	n8JCW1D335GtxY6nX/6LKYiK76cOq3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-krdO-0dNNGixB0Ek-KK5gA-1; Fri, 01 Aug 2025 12:03:14 -0400
X-MC-Unique: krdO-0dNNGixB0Ek-KK5gA-1
X-Mimecast-MFC-AGG-ID: krdO-0dNNGixB0Ek-KK5gA_1754064193
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458aed20a9fso4128295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754064193; x=1754668993;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMRSYj4Eiotram2sHuDHJExcsIVaBr8JOLhPuPHdhRI=;
        b=lllzgADTR6ov/KnN6+i4UKF+H9BaO+V97BVQnY7sDghMWryC0QlNUwLUBU20ntnQ3k
         11l3Cy110il3Lj3G/aBfa5TjsWzrX2YF8mp0OCzLG1vu52uHwVfkvyns0rHgG4pVIiC9
         uZXzHX7nVJYmtVU7OUto0dUZJBFU2h14kskFxwVS3D5johAgcc7fog+HJa9eKyq2I7w7
         2FRDfnUKRrqHWQYvTx2JwLh/NC3z/q+7AOSIp8jzeT8C/vjdj5X6ZOkIHMUreyBbQBY9
         oX+d1vHfr/BbZmPxhWx4S3pluL5081fEV+b8zRrlB1ztPL7uPad1FWDBa2fp7lif9AZj
         VJ5g==
X-Gm-Message-State: AOJu0YzKUjDUR8Isqb+lwOGjoaF06YValfN6GnyzxN4v6y41JBIMOARC
	5g/qO0YTuodr5o/WJ/okn0yduNNERZAI8SfeKPtnfTltCaiFlUO2PC0ZyhKIB9nZlbJrkiNsCNQ
	cDC+kuRpNBvOPLBBBGvB3AaPKZH4k0KlS1aHOV2URsb9ZKKHZ3Eu+S2PCknmKR7KEb8EyDOInyv
	jQ
X-Gm-Gg: ASbGncuv6piG1sk1pzEbKjmmBgsNTvrwKXYsrJ+134sCE2zN+3OX7i7bHD6U/Sjknu+
	slGLQcWnrKmEG1v6mFoskyLg5XeGur+i27NEeBO7RVPN/xg8orANhZaB6qVqpuGPoh9p0DIQMQg
	FQ24OyM6Ig00BbfzxtqU/j7DzsG27wl2nTF3SCTznQAuy/5KBJrGmzb3MYYu+GVm6yvNQmVd6E2
	T+OcvpqvaArx8V38AjA5wmZMTOMwXysnYuIGAqy9uctwUW5ZFqE5BztSohwrucnS4g7kX5LliVc
	BjGb/PV1hjI5gULijmFq+O1Rb7nVhFYJdJArfiQBAykcDZa//VF8ycei1GXDT963CA==
X-Received: by 2002:a05:600c:8706:b0:456:1e4a:bb5b with SMTP id 5b1f17b1804b1-45892cea07fmr100053595e9.32.1754064192644;
        Fri, 01 Aug 2025 09:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpHFN+pfRBNzyHHdmUW/iRK6kM8LUuFBQ2WK0phy6SH+KCRgWuXRMrJhznxXKQiJUaaGwLfg==
X-Received: by 2002:a05:600c:8706:b0:456:1e4a:bb5b with SMTP id 5b1f17b1804b1-45892cea07fmr100051305e9.32.1754064190370;
        Fri, 01 Aug 2025 09:03:10 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af999486sm13440465e9.5.2025.08.01.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:03:10 -0700 (PDT)
Message-ID: <b2788740ecc02ae70706506468bb71a1e23180cc.camel@redhat.com>
Subject: Re: [PATCH v9 7/8] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
From: Gabriele Monaco <gmonaco@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker	 <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 01 Aug 2025 18:03:08 +0200
In-Reply-To: <bdbc1a11-1546-47e6-bb14-d3ad940907ed@redhat.com>
References: <20250730131158.101668-1-gmonaco@redhat.com>
	 <20250730131158.101668-8-gmonaco@redhat.com>
	 <bdbc1a11-1546-47e6-bb14-d3ad940907ed@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-31 at 11:39 -0400, Waiman Long wrote:
>=20
> On 7/30/25 9:11 AM, Gabriele Monaco wrote:
> > +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> > +{
> > +	cpumask_var_t full_hk_cpus;
> > +	int res =3D false;
> > +
> > +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> > +		return false;
> > +
> > +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> > +		return true;
> > +
> > +	cpumask_and(full_hk_cpus,
> > housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> > +		=C2=A0=C2=A0=C2=A0 housekeeping_cpumask(HK_TYPE_DOMAIN));
> > +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> > +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> > +		res =3D true;
> > +
> > +	free_cpumask_var(full_hk_cpus);
> > +	return res;
> > +}
>=20
> First of all, isolated_cpus currently include those CPUs excluded
> from boot time isolcpus=3Ddomain setting, but it also include new
> isolated
> cpus created by used by cpuset isolated partitions. Your current=20
> isolcpus_nohz_conflicts() does not check isolated_cpus which I think
> is incomplete.

Right, good point! Thanks for the review.
Somehow it was working fine with cpuset+isolcpus, but doesn't work if I
have multiple cpusets.

Thanks,
Gabriele


