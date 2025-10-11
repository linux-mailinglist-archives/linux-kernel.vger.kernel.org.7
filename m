Return-Path: <linux-kernel+bounces-849014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C9BCF043
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D993034D6B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C31F8AC8;
	Sat, 11 Oct 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ5HdD3a"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F021400C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760163039; cv=none; b=d1mqt+qMgi9w8xEvyIRdJqSjFA9Xj1Zqdf0cQcoTo//B/zdn+qOBYLIb/J42jsl2hpGhCm30ZCxQpCrvHqtYzgJEoEoHQKTUuQ75DmMY+ut20ovIBJezVG8BD7v8j4UcYGEAtPjxDxf4T7XF8qvdS1gFTlu68cbijiJ9Bf2wqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760163039; c=relaxed/simple;
	bh=2p+amGVVgrGjR7T5iXx7r5yyISJ2EeCii+Sp44vNGMw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OuZ2HnbEf9KOcdRKTmiI+82D695KU6D/hv4bcAkLXsv4hYH9FJH4IJamTjtulcUSNtPcky7GhzkzLY0XhLTU4sFVizDcxXD8PvxzhBqC8lLbDEFuVWo0eAy5kztBpCZp5sd84+C9DEy6dRZDf6z85VvhXW1TdkQOM9zmitj99zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ5HdD3a; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4f323cf89bso474500966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760163036; x=1760767836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ys56ihfHd4N+YA1C7C0dMZozeal+vxhpAq3e/Yrq9co=;
        b=OJ5HdD3a0fZZbpKyoqZxKNa6Ma2r3Pob7qKsFdh8d9h4YwLQwBmAuO1Z7s9b59eATF
         UqtFE2ex4OmU5/My2yvAibC/DJbcWj++bfav5eSanGpfnOzw4CVs8cUSYQCLfreFQV3J
         DbZ0A4XkJxrIw1UfkdlKulH7Y/5UsdU7L9BhO/B3wlWTgFuBs7CPe6Q0OxyPhtWVHgCZ
         m83yPRZnENQSUajgeQAiWQMUzMleS9/BZ885dJ2AdKL4w0zRSiSgFdwLoowo71YZFDp2
         Qz7tNGWidUyYgVY+S5X8ZOUsWvdonY26Wi4rfrsYspamLMedZF8JOXVmrsgnu6pxmv2U
         K0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760163036; x=1760767836;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ys56ihfHd4N+YA1C7C0dMZozeal+vxhpAq3e/Yrq9co=;
        b=T3LVGDfimAwy4yI2XPtfLaGanyKE2eEs3L8GRINVmmQnRORgFgJKKG6ZIixDzHiS7P
         VmWdMzU6TXydOqkYJysFpi6YXe2R6kayPubVv/ZOx3nmHkopiPuM7rYhqkaRgzoMN0dW
         iUVgYI5z5txj/b7hhv9+ntm9JJHXQUbUDslhsJ7DbMLAN+dYC3GoeqB7w4hzUVC3tHzF
         QDLqANtQq7IlSPfIwg1d2Xivh6KSskX+1UMqfDGSCTz6Hhv5IQ0fVnweo31BjGqyfgzM
         i2NtIP8eCORsUAYj80FtrQmtZNs6kN2jvrnUZBad3vWn5vydT2hnHR+72OI3j7Vawbn4
         oN7g==
X-Forwarded-Encrypted: i=1; AJvYcCXNLM31qP4LkYVn35g/4HqlCstzWjBX9U23C+Fg3gXbmyB/n7Sh9lOiI8AbkbL+FZbOW08hMsOYNTKpUyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Wycag7iZuqCx3BCp3cTlQ+E9Hut0jR7PS4g4i00b3zr6fUGz
	7DaKA+s8mgUkwxC5li4myY8MKOEKm5jejzu3owCfqqrigFZf9cgcczrD
X-Gm-Gg: ASbGncsOGi2wM6rBS6ksdhGDWDIF6k9lMlUJJrPxe1d00vx0R2YgAmegiA0EbsE5FVb
	bFsd1Zm0kZw30zZ8sUW/SEeSZ56mtr+7ujMFVyuWk+ts8KaOjHGF9qeDq0kuUeUokEInsH4rq03
	6+lqW6Bd6vJv8Jn/y1Iv2SgVUoxSJaqbKOAnSN4DR4P3OzLIEfb3augoUuKvo5t4j2ItBRcJJGY
	u8MmizX316DzA3N1zETUP+edo1hi+ITuVrKejBDugpURVNzturYgEP796R9+Iu4/eqtQ0Z0Vqdf
	6h0CkqHsY5rxrpkXwbt44EGwdC+ggxZtVRRCUs2Mv6m2zJ6qE+Bo5LvK8AdQjjzhyl0OG9a00M+
	wosLhwlXEnx7/pgvNzvEeR5n5tD4VzNvzVSOzl+62xwQtvPzDzy+fNIGEntfTgpy9Ldimsyru
X-Google-Smtp-Source: AGHT+IFlXvGm/JVkQJIR7wHjuMbbVNDorvAS5E7Ic1ASbNZlryaphTiSRh+vYp+gWuP/x6lbjhiQOg==
X-Received: by 2002:a17:906:730a:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b50ac5d07b5mr1353198566b.60.1760163036070;
        Fri, 10 Oct 2025 23:10:36 -0700 (PDT)
Received: from ehlo.thunderbird.net ([91.187.204.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900cb5esm403487166b.61.2025.10.10.23.10.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Oct 2025 23:10:35 -0700 (PDT)
Date: Sat, 11 Oct 2025 08:10:33 +0200
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Arnd Bergmann <arnd@arndb.de>
CC: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_MAINTAINERS=3A_update_entries?=
 =?US-ASCII?Q?_in_ARM/CIRRUS_LOGIC_BK3_MACHINE_SUPPORT?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251008095112.104995-1-lukas.bulwahn@redhat.com>
References: <20251008095112.104995-1-lukas.bulwahn@redhat.com>
Message-ID: <ECE2E37B-5A1A-493E-872F-B3543B40142B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8 October 2025 11:51:12 CEST, Lukas Bulwahn <lbulwahn@redhat=2Ecom> wrot=
e:
>From: Lukas Bulwahn <lukas=2Ebulwahn@redhat=2Ecom>
>
>Commit e5ef574dda70 ("ARM: ep93xx: delete all boardfiles") removes
>ts72xx=2Ec, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
>section, which is referring to this file=2E
>The BK3 machine support is now provided by the device tree source files i=
n
>arch/arm/boot/dts/cirrus/, as pointed out by Arnd Bergmann (see Link)=2E
>Update the file entries accordingly=2E Also add Nikita Shubin as maintain=
er,
>which is proposed in that mail thread as well=2E
>
>Link: https://lore=2Ekernel=2Eorg/lkml/d125b5a5-8118-48ec-8af4-243a217170=
df@app=2Efastmail=2Ecom/
>Signed-off-by: Lukas Bulwahn <lukas=2Ebulwahn@redhat=2Ecom>
>---
>Arnd, please pick this quick administrative fix=2E Thanks=2E
>
>I noted a year ago, I will sent a quick v2, but this got onto a pile of w=
ork
>and I only now got back to this=2E Sorry=2E
>
> MAINTAINERS | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index f41dbfecec91=2E=2Ee6e615954c6a 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2558,9 +2558,11 @@ F:	drivers/net/ethernet/cavium/thunder/
>=20
> ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
> M:	Lukasz Majewski <lukma@denx=2Ede>
>+M:	Nikita Shubin <nikita=2Eshubin@maquefel=2Eme>
> L:	linux-arm-kernel@lists=2Einfradead=2Eorg (moderated for non-subscribe=
rs)
> S:	Maintained
>-F:	arch/arm/mach-ep93xx/ts72xx=2Ec
>+F:	arch/arm/boot/dts/cirrus/ep93xx-bk3=2Edts
>+F:	arch/arm/boot/dts/cirrus/ep93xx-ts7250=2Edts
>=20
> ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
> M:	Hartley Sweeten <hsweeten@visionengravers=2Ecom>

Acked-by: Alexander Sverdlin <alexander=2Esverdlin@gmail=2Ecom>

