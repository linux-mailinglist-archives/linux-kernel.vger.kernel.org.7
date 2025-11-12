Return-Path: <linux-kernel+bounces-897477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E1C531AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01C275075D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E1338F5B;
	Wed, 12 Nov 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvFf5Akn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685532BF20
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958995; cv=none; b=Qr9rV38UTMh6pEAcgx/AWJq9lPURytLlWRZYjoXO1KwOr4PUyd2QswNmwXqH45QWw/hoW5gZ8dXeHKSXu+HkSz8Wu7ZsEVWmCESea8g0frRu9Fa31kVlmEauJdeLWKpUg7JGfrQq7qn1qTrhzHK0aRCcQ+TfQ3W0nq+bqmPHIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958995; c=relaxed/simple;
	bh=kpy1s1xaB6iG4Gf4BGMO7YSYxvPwEoa7tJuEDNtxZtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M200F3xXak5prqXUr/UcCSZCFqlmvspHEYv8Fyp616WdcNMfE5NEN3RX2ozQ+HqQcH+Rtx54KlkjNsiEtk0joLWHC112Ev8slVeMhjVQI+C26wWBMCa/rkNzP3DIOMJF5CZDunDd7uATCYzkY394E0H2uoaXnYeOBr+ylu2QsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvFf5Akn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5942708701dso123496e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762958992; x=1763563792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiKqH2E9J1a7cAyDCuQCYusr6Qowg5O1ujBGI90a9Ww=;
        b=CvFf5Akn76ywHArZh9IjERDszoZA7RjQJbxr1tKFBMIpAU+2yRx5mALwqOBpG6ak4M
         HFoIugDbvRG/EDRrvDUEJVZYE05Vtap2sXsJfwoZxHmD45hDxcPgMPFCMSiN+taf1JWD
         iMHcoVr6zhDqTrhrCCYA8TqdEHvRNXLu7e+ZEnK9HDbUWJIkH7pbV2Sr6WIYCtRP+rNX
         wek5MmXtXR/5Kw5E5SKhxvrCmVG6d2kz6lqopCiclX0ZQPKqxFwOHUvgrDuJKBnGjPuC
         HlTGHz4Dic0so29BIf2CtZLC89AFq30cQRjPJriNHOX5P2qOz4oNeq6cWezvaH3qzDK8
         e1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958992; x=1763563792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZiKqH2E9J1a7cAyDCuQCYusr6Qowg5O1ujBGI90a9Ww=;
        b=sJo40V0jguULD0L60ANxBGYs5tDA66E1fRaQBtWumngBnjXJdO0bnvvpD1qfofXjnn
         QPhg/eR10uhe75mgQhCV9oB6iMfLuay6Yw0VWv7y/flUZdv9tc1k1SBbZ1ryyry6V0vQ
         aB7+9T3cQptIk7iqDHQh9gnpTPqsuALJ1QyjgPVqTg7Fkwwwf48uNJrHDw/J5wmeyzcW
         D1BudubxuCymxCtJbRSdwUFkYkfIYobUUU5Fr+uDRs2YHgOHAuwWX7mGCZogU0ngUVAU
         4/3IOtHQ/bqaU7kYeT0jbMpbOLj5+WDrsk+4ON2XkEE4D59uESUoPDh0dsRieJbaRHFI
         rSUg==
X-Gm-Message-State: AOJu0YwkakqEw3NYhAnjWOfZeKNRTUCsgQQ+5SChs4+FvEczNI+qQ3Az
	CeNIsDbeAjrKfC0XTl+n8Xu8BH9z/pBIpKo+237YCxPNb2dmOVuLZyxcSuoZi4bNi6IGsfSnLNU
	tuyOk+D3vAqn4RJfaRnNWz5eQgr6xTmg=
X-Gm-Gg: ASbGnctAZC1FwuHUV/PLYVQIoFq17oVSxjAQ8H428sYyZjECXSR4f5zk8XgqWjOzrJC
	XdC7HDWNez3w0Wz0et8EBpG7uSzcDmZzMOlFNJoBse0moDxiM2ybsoHvi0pgdRfSQTCR+f7/m3t
	2t1rWN2oin6A4bshHRagy5SvZ6Yk0wXCA4JFKCANfVt4qz0mBiTCyIcMLIpFkjM0paJ+loN25wc
	0SfqHJna47ibZfMobkq0GrowBFg91e8ljD4xGkFBdGClgTClLZMXbeCorwZtcU4WyBrLyX4K4uu
	A+09FSnKJoBUPgt7Kww=
X-Google-Smtp-Source: AGHT+IEsnpGPTgeQ9fvbme0GPiEC7gZknbeEpO0Apcyrg4+vEnXkmXVvJcj1uLdZtLatFnK/AzpnpBKBC6uiSuY8H90=
X-Received: by 2002:a05:6512:39c5:b0:594:4c87:a8f9 with SMTP id
 2adb3069b0e04-59576df6301mr580973e87.4.1762958991752; Wed, 12 Nov 2025
 06:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMz+-CPAeuET_d_2b_tNEdNiVT1R7mzLYWih+nKa8=Dp0WjqHA@mail.gmail.com>
 <69149359.050a0220.3565dc.0001.GAE@google.com>
In-Reply-To: <69149359.050a0220.3565dc.0001.GAE@google.com>
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Wed, 12 Nov 2025 20:19:39 +0530
X-Gm-Features: AWmQ_bnoAaXBFOjx0dkWdXWewz_lGRLeS4Xu6BafcdoSmH5yIO9N834RETKFZTU
Message-ID: <CAMz+-CNc9gSbvWXG5BT6-+j_QKQ1Ac2mKnNDqvjzvKVR_ieHFA@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
To: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 23bca5e687c1..150c5c632c54 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -963,13 +963,23 @@ unsigned int cfg80211_classify8021d(struct sk_buff *s=
kb,

  switch (skb->protocol) {
  case htons(ETH_P_IP):
- if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+ struct iphdr iph, *ip;
+
+ ip =3D skb_header_pointer(skb, sizeof(struct ethhdr),
+ sizeof(*ip), &iph);
+ if (!ip)
  return 0;
+
  dscp =3D ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
  break;
  case htons(ETH_P_IPV6):
- if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+ struct ipv6hdr ip6h, *ip6;
+
+ ip6 =3D skb_header_pointer(skb, sizeof(struct ethhdr),
+ sizeof(*ip6), &ip6h);
+ if (!ip6)
  return 0;
+
  dscp =3D ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
  break;
  case htons(ETH_P_MPLS_UC):

On Wed, Nov 12, 2025 at 7:32=E2=80=AFPM syzbot
<syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/wireless/util.c
> Hunk #1 FAILED at 963.
> 1 out of 1 hunk FAILED
>
>
>
> Tested on:
>
> commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D878ddc3962f792e=
9af59
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D17cfe53258=
0000
>

