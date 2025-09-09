Return-Path: <linux-kernel+bounces-808515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6384B500BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B672C16D4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12D350D5A;
	Tue,  9 Sep 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a0r+SLzK"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21792322A39
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430819; cv=none; b=Q3UNl0zqMfgPKCOIjX8oOJo7E34JPOzSzfwqrItDkTUXe8nTM3ib+PCSzKfS97n4hwxkn4CNudhLK61Vw23YlcgGV9BKMDr+2p+RLjsfFLbQKMVLf2aJq5NNF7zW7Dx996G5moVDHh/PB/4Cq1BJSFfAMDX0aeXMV6k9VqJd718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430819; c=relaxed/simple;
	bh=Ba0OhIjYTLMiU3oxACpeC2jlMILOb4FcyPfqCiUaRVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ach2Ni01M5osbrAcM12mZgkzoc6kjCyyBZkqP3OxomFzWnpo/nwiol8s3FLxD1y7QDKOOfy+ElzLviFUddI+pFoyegjmJm09KXttQXPHx8NOZDzNsW/1MsLe3NT//bRi2hz4Ra7/ghFSeA4VgONsmTyWgO+osJQS0o5xM3ZGezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a0r+SLzK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-560880bb751so5748646e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757430815; x=1758035615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGh77ZpqmdGlBlK4akr3+AuuurmRl+8arU8n5sa2puE=;
        b=a0r+SLzKO4nLhffhhxISPeeOcYenjGwlRwTnNnN7/nsiq75oOC/HxvlWvhmjcMkJDC
         7DApqJVzNIwfnUYz/Hz28aAn85+3Mjrr8uykQ/OYj7enP+oXZPKDBAH0xjgSBeCpa1Iv
         VSGZivsfZbvkhWH/sv43h0n68RnoodaChBIgA5LP9aKK33bFJNCwdxkVzqV1D8CS9+79
         +n4sfo+4+BxO3uTOWs76Payxm8Jdv79krkGJVWlE/+C+DCKzWhzVVE7k9kOjtA5rnzyM
         pAEMDFE/yOiszEha+fjYHbjXvsVww2uN5QysgpDYVKcUEmDg9tnhcSAGhOYnqpNCslv6
         udzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430815; x=1758035615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGh77ZpqmdGlBlK4akr3+AuuurmRl+8arU8n5sa2puE=;
        b=pmo7OasFAMDDrD5YcdiLkRQKgWLkt74/7ML1H2f5fmvq9tpSWBgRzphGjyTnfg4VAf
         SMe0cqvQR8gvAyzJ19J9d1aRhg/Om8XJ3/Sn5un4LdXALuivplZTq4IepvzmhD48RUWJ
         3jDi6TFcR3VUg30zR+onUmGmou2LlcJPsDnvSqNZpmvEOLAttxGJCB5Z4uYXe5+UPfuE
         RCMNfgc8I8RQMPwvqftb/Pi0KsX4JqwMi1s+ZPI3wRRFRVR407KCGF3+xh9iIDZkhxCS
         vnzX5jVtOTA4P2N+9PXRjs6/VccoIjTe0hCxfZzZg3G7RDanmMVcdUYzFQGDCg324eke
         ScYg==
X-Gm-Message-State: AOJu0YwKYv4X1oMYT9EW3gxXBXiyeNTqrmRyNXMtO9XDuUmjNvLzh3Dt
	0ETQtDOkPVNhvYZqDr3h2Kqhsu/vz1fxKzZwRQAFsJde8viJeDRV6GD0QbbjlEIh9OditWnfUPD
	ETN/VMGpeiz5A3p007hwwIzmCxUNq+NGbWsVyEWiGAA==
X-Gm-Gg: ASbGncvyPx/+5pomV6ffDj48KEiXRWzIaj3opGXIMt9pxlFT6TleQwFNhzRVr5nOaS7
	zjbbSA1vxnchritlKGnwGDOXK13lpa6wd+oVEM5/RGa9XxUwYY1n7CRnPoTLwHLK1Hu+yziZLnw
	pZs4FsZ0rSUcrdvI1+dgQYm8Nh4mlUGNL9eBjByGUjaHzhJOfnrMlEpUCM21zGf1rGfI7q0UQvn
	Be+A6oPgYCOwErCW6j6EqqDr+1ZEJddv0ek7Tjon8TIXPTWpE8=
X-Google-Smtp-Source: AGHT+IFSZyUfZN83V4CIF15pJ9WW73KK6A3AqmzdyuMeYCc1Xez+//dyjWNcpjNv9xi63JQzWXyoAh8tMA846TPE074=
X-Received: by 2002:a05:6512:2902:b0:55f:6d33:f37d with SMTP id
 2adb3069b0e04-562603a2906mr2874685e87.6.1757430815093; Tue, 09 Sep 2025
 08:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090240.102790-1-marco.crivellari@suse.com> <175743072926.109608.13668500662715928702.b4-ty@kernel.dk>
In-Reply-To: <175743072926.109608.13668500662715928702.b4-ty@kernel.dk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 17:13:24 +0200
X-Gm-Features: Ac12FXyMadLYuOZrzk6-69qVQHbOFQB4QKKKuk42CzSO_NGvI6rDPCTY3mupUss
Message-ID: <CAAofZF5XsHsWSccR00bTut1A-wgNftMOZrwP9zqc=YQ=-rj68g@mail.gmail.com>
Subject: Re: [PATCH 0/2] io_uring: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:12=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Applied, thanks!
>
> [1/2] io_uring: replace use of system_wq with system_percpu_wq
>       commit: e92f5c03d32409c957864f9bc611872861f8157e
> [2/2] io_uring: replace use of system_unbound_wq with system_dfl_wq
>       commit: 59cfd1fa5a5b87969190c3178180d025ee9251a7
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

