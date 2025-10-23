Return-Path: <linux-kernel+bounces-866744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158BC008BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF2419C6761
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D86308F3E;
	Thu, 23 Oct 2025 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMZmyn7B"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6428A1F1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216132; cv=none; b=c5pxrzAQ8/cMMIpYE59ppyoMMnUwbos6ZQmxDsIE3dnCRnkZFXemrVhwYFWFvsn5EbIW/UK+tITpdcuZ56IQZGJhNGOXWhpeYFzB1xmqxnJX/nrsbVhronuLNlyxte5aOtDLjKWw9ZgCLAGVuAa5SMWqJzCaYoZDUSzljd147Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216132; c=relaxed/simple;
	bh=jyg2eZ/1XdoAlTqduehdddaNsDWPY2qdFBzk6zBgRik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZSJ4BLShQW2p49S/j+bYY0PfcY8lBOwaayV37363sJ/qtLpxWXsaCLnuooJBg6m0LfZ4Z7AcoMY32jqtCdJMawEru8iLB1LSfjqb6mAHDFO7QNetwNvwKLLTrzGKRDOCIck5YSgSBJwucHUS563TFCmi0+zdyZTme9d1c+2I4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMZmyn7B; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3d913b3bso1209170a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216127; x=1761820927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNwYeVe3zrzgI77kfJc6mmnbUyU3J+W0mAD5mBv2bvM=;
        b=KMZmyn7B/WFxXkWm30Gzod9FYX4imYKhDQ9n1mJTerhcsgny+cgqDx+hERs+OAOARl
         j9j5G0crdnySPQ0Tuv7uzQkUTF6OaFlYnvKyzM4BzQAq4w0DOUxGTwVD5dzewb8DajjA
         NfH5APIxlzWnR3+FoRyz67FRmy7k4mtHcfxlTM0TFbOn+G52nu0pPdcWyvTTKw0BIPpM
         Mp6Cp2v+WWHTERxkowt5/9tOkSaorOxci/ahr5N+pC2w/lUua6eEjg6bKgR658/nxFE2
         ffjOM/9n7vSEYkTvjkSH4Wsabm3gcHPe5YBtV2VwoOK/UX3Yq8pidgxPDkUwIKcGkSnb
         H2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216127; x=1761820927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNwYeVe3zrzgI77kfJc6mmnbUyU3J+W0mAD5mBv2bvM=;
        b=Ito2zaPeaMXuUoQnbK80F2yL33EYI256e4JWfOWSjArtEaY9kTxVXfID11+FAYhQyT
         agVUKaSMqnKVP25GoiFfyvns7WfCDGcKnxeRxoLs5UejCkF4EVYZXTup9R1Eij3MUDMv
         CNP8nokDSneTfOkdYeIPAWp7srwsAM0L9OCwCrz2vAa8lIGxZXLBui/BaqBvLvLqHvyp
         42NqWM1V9nmp/fBwTgnKcvMB70G7bmrK26lXmrUoHvOpJtSQrAFT5SoUM8NLxnAg/IHd
         znMd76eXO5h1mN9wmU/cc6WUUWOeLFCoGAR+9yaUYk31AouDrEkGqVrTQBfGTA92pa1K
         mlNg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Z60UkjvXHHNnGlKsFXdT9DnfpgEE0C41aFoNuvlLBwqx9K2UTebPkyHN0j2DdwLqgSHR7mc2XSstx9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCioynZXqngUFnP+tLALeTDUB14HG6JbdhWCEHtnW4JQFZSpp2
	UAckpAqfWwWxhuxHAwpPn1ThjyZq53ZN3Xro9vToX4iTOFDJGrOeY4RAC4g+YpxDz3xzMq9CtPD
	fLopZFj82HdTr/vBK6U46DBBUwEs25IQ=
X-Gm-Gg: ASbGncuGR1+SKfSPpp6DxYMTmP0C8V9YkKfSwVXrL89FXqUt69o415xGEs7CbfVmgSZ
	YyYc0gDrhlMxurd7rODovUhMS/Lw30fatIS8qFAclCAotKcBwZodfGU3Y/EroZgh0bTzuzlxfHo
	s8X7u2Zce04ZhAWKSPNGa0P4r9vWVC4mWa7XCjlIcf5iY6ozS6wHsIbb0hOhKuYnQNnNwYReKHW
	27la7KEJFuw6N84eY5QESwThSriyx0KgupQngUBS8uoCaG3RgmHYa+cazc8d8frKX5HpVlWzc7b
	1gGgjfi0tG6XH/v4BuHz8Hsm0AzylQ==
X-Google-Smtp-Source: AGHT+IHj9sqZlFAd6qPNTa4C/OpRKo92Gcn6zexlmgF4iPE+98wHJzEkw8o+T+JQbLSjLVQOB0m1KT0oZjfCmtuivL8=
X-Received: by 2002:a05:6402:90c:b0:63c:489f:df5 with SMTP id
 4fb4d7f45d1cf-63e3e10eee3mr2179427a12.16.1761216127196; Thu, 23 Oct 2025
 03:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <aPiG_F5EBQUjZqsl@stanley.mountain>
In-Reply-To: <aPiG_F5EBQUjZqsl@stanley.mountain>
From: ally heev <allyheev@gmail.com>
Date: Thu, 23 Oct 2025 16:11:55 +0530
X-Gm-Features: AS18NWBdMh0RmpDPGmhjn_SnwsO6o_RPLnVM52wrjLiLq5epUawW0vv-w1GvPEY
Message-ID: <CAMB6jUGhcJ=W3s96jRBHHTyPfBm+-+d6-VQQ3mXft7=fBJ0jvg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hunter <david.hunter.linux@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:55=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> I made a list of the warnings this generates (on Monday's linux-next).
>
> None of the warnings are real bugs.  Every single one of these has the
> assignment as the first statement after the declaration block.  We have
> had bugs because of this before but Smatch and (I think) Clang detect
> them so they don't last for long.
>
> regards,
> dan carpenter
>
> arch/powerpc/platforms/82xx/km82xx.c:30:
> crypto/asymmetric_keys/x509_cert_parser.c:63:
> crypto/asymmetric_keys/x509_public_key.c:151:
> drivers/firmware/arm_scmi/shmem.c:199:
> drivers/net/ethernet/intel/ice/ice_flow.c:1576:
> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1015:
> drivers/net/ethernet/microsoft/mana/gdma_main.c:1508:
> drivers/net/wireless/intel/iwlwifi/fw/uefi.c:821:
> drivers/net/wireless/intel/iwlwifi/mld/d3.c:1788:
> drivers/opp/core.c:1413:
> drivers/opp/core.c:1480:
> drivers/opp/core.c:1797:
> drivers/opp/core.c:1888:
> drivers/opp/core.c:2874:
> drivers/opp/core.c:2935:
> drivers/opp/core.c:2989:
> drivers/opp/core.c:3065:
> drivers/opp/core.c:3085:
> drivers/opp/core.c:3104:
> drivers/opp/core.c:312:
> drivers/opp/core.c:330:
> drivers/opp/core.c:412:
> drivers/opp/core.c:450:
> drivers/opp/core.c:608:
> drivers/opp/cpu.c:157:
> drivers/opp/cpu.c:204:
> drivers/opp/cpu.c:59:
> drivers/opp/of.c:1272:
> drivers/opp/of.c:1331:
> drivers/opp/of.c:1428:
> drivers/opp/of.c:1469:
> drivers/opp/of.c:149:
> drivers/opp/of.c:1505:
> drivers/opp/of.c:174:
> drivers/opp/of.c:276:
> drivers/opp/of.c:352:
> drivers/opp/of.c:409:
> drivers/opp/of.c:48:
> drivers/opp/of.c:98:
> drivers/scsi/scsi_debug.c:2964:
> drivers/tee/qcomtee/call.c:648:
> fs/overlayfs/params.c:451:

Thanks for reporting these. I will try to get to these in later
patches. But, how do we test the changes?
KTODO: run checkpatch with uninitialized pointer with __free attribute
check and fix the errors

