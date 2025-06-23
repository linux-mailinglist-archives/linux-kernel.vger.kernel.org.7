Return-Path: <linux-kernel+bounces-699037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C9AE4CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D5D1899D55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE812BD030;
	Mon, 23 Jun 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WmORnRdQ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DF4C83
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704346; cv=none; b=mslJITdt7Voy60lqPsMswINcZbC95uc5jEuASlwjQ3GGeacahfZ1+bHypMLpAnhmwCd6TGpyC887nOlaYf/z5q3IdndbnLCuZa+bG3aNTK3f7OVmx6FFLAukfykS3v8i7g53aKn+uiuQxL94di6uBn74/Ozyovc71NTonNad80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704346; c=relaxed/simple;
	bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snZNb8D88DHcJOYB4WfbDeg+Oh6hiUlxVYZklOXD6UIjcP1mL87teJ4zBgdXVz0IQaRHVDZqXLSd1X8Pxl+c7Br8IKO+jNgBo1KYtvm9TwXoPFaY3Ngur6mI4TJRDK6tfJLkAXe6qHxIg7ScWthN8Yej40igh8ERuCbVgfmZ0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WmORnRdQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3664795f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750704343; x=1751309143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
        b=WmORnRdQ1bRXiW339VIWESeowWbm3d1kwGgrd3eGg2E7BAkkyCo0+ONJxnV5iX83/2
         rkjAYl19WKJUesKyZF3cH69dmzqPrl7r1l6gPcu7Yf7pNKYQfxKsBzFqiomy871HFTk2
         IsM0FBgb5884ryFQsSR2GU0mmARJWoWxbhkxcDfVvhgrDF4ciPS2mvUplIAr3waUmh1k
         NFWrzTTVEX7Ybq+pxGLStlsH4d9QDGuhX8p5IgTKRLi6nviVhgEIf2E6b/OOd4DRxYN+
         kpvZzsJXzDEu6WN0asWvbQk6FI2ZUtvKXby8qv3fCR/Wx1zkv1fZWUlA5HlhtQSRFJNZ
         yNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704343; x=1751309143;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jB4MKuZY+Ffi3QK7qpUEThxOxdtk8engxwoxg/tQK+M=;
        b=HHkmybVd9KTFsavbLHMC7K92QbsBiEoqg0ygfA7NDJyoOpGdR9zkWDBes0CE4uuVOf
         51/W7DvvrFhwUD9YBlcBdW3LI1N1oBtnRbbad0J4ibLFGjyIqVuJE6eHh0FL7++hnbYk
         xuXgsBsJS+11XsUQH1tfdVmkos4hwFlSRplfNQ2AidKGX2AXWdV28U0OEYT1RPpq7AIs
         yVdcm1CNSHghGGXjOAMcb9C3jSNzHI3mkvI0g5ve8gqDiOQ3KgTUCY5OxdZqUCYaJzqq
         wrpIOHp9Mro6uVWxtLp29YHUWjpC82zoCyMf/9eUFfoXSCYvG+rpy6DXQqxrJEgXldHS
         mzKA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ke20SSNLi0TCZQ3hVXUeXIbbfkMOrLJx2U64gEE2TB0S8ub6yG0zdyTV5sPyxq6a+segerEeGJgG13o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzILrjrJPsFIquTiHbp3tZGXiGjEu5j2orPV/h+KJg+2XdfdR5H
	2LMew2HxbG3NF02R9zbW0MQdB0PGrudYNvb/wGLkTY+X9NgGgsOsVhN+KJ5aRLmHUR0=
X-Gm-Gg: ASbGncs9RE7qS9ouGIkzXMxFTNWfQ77ix0qpvmlngnIfiUrr24y7pRYCdd/h0n1dmJf
	ZhexLpK8DwFjhVs6L1m2M4fTV+FwbLaf2ohb1gMVq87hMmGBr0DLwePeAM9pYdMXg6cbOUS4rsp
	SSxrwrlwRA4geD9qegdwmhEL7zSJ+y/8nAqPfYpb/yrPW3mDZlIeqhZDxHJUQcWQHfkUT5mNHLU
	RWt7gbyMlEJFoXDl6Va/Ee1dHbKE6ZlYSQuMmlehcZvn2rxsANgabbsXDRhOs2359J1MiaZSWFH
	wtlDRcx9x3kqSnwoIbpcDeozO3KsgEfKa/IpA/lO70k9vRXoG0djIyxKtjkTD46zRIcyHxqFteM
	IY5M9SxOTJW16rTGDFiiV9Rln
X-Google-Smtp-Source: AGHT+IHDRPumMTiGBj2bKfNpuQzAm+7VlyB5Tr2Ge/4ynqkxj9vUq5oRX4iaFtPKRy4untvXuea0VQ==
X-Received: by 2002:a05:6000:40e1:b0:3a4:f607:a5ad with SMTP id ffacd0b85a97d-3a6e7206acfmr430150f8f.19.1750704343074;
        Mon, 23 Jun 2025 11:45:43 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6ca165sm9303644b3a.172.2025.06.23.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:45:42 -0700 (PDT)
Message-ID: <49eed036f3c230d066ff44620c222fe5a2c3da1a.camel@suse.com>
Subject: Re: [PATCH 1/7] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel	 <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Date: Mon, 23 Jun 2025 15:45:37 -0300
In-Reply-To: <aEq9_kOoLSQwuYBq@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
	 <aEq9_kOoLSQwuYBq@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 13:46 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:43, Marcos Paulo de Souza wrote:
> > Since commit 9e70a5e109a4 ("printk: Add per-console suspended
> > state") the
> > CON_SUSPENDED flag was introced, and this flag was being checked on
> > console_is_usable function, which returns false if the console is
> > suspended.
> >=20
> > No functional changes.
>=20
> I double checked potential functional changes. In particular, I
> checked where the CON_ENABLED and CON_SUSPENDED flags were used.
>=20
> Both flags seems to have the same effect in most situations,
> for example, in console_is_usable() or console_unblank().
>=20
> But there seems to be two exceptions: kdb_msg_write() and
> show_cons_active(). These two functions check only
> the CON_ENABLED flag. And they think that the console is
> usable when the flag is set.
>=20
> The change in this patch would change the behavior of the two
> functions during suspend. It is later fixed by the 3rd and 4th
> patch. But it might cause regressions during bisections.
>=20
> It is probably not a big deal because the system is not much
> usable during the suspend anyway. But still, I would feel more
> comfortable if we prevented the "temporary" regression.
>=20
> I see two possibilities:
>=20
> =C2=A0=C2=A0 1. Merge the 3rd and 4th patch into this one. It would chang=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the semantic in a single patch.

I liked the suggestion, I'll do it in the next revision. Thanks for
looking into it!

>=20
> =C2=A0=C2=A0 2. First update kdb_msg_write() and show_cons_active()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to check both CON_ENABLE and CON_SUSPENDED=
 flags.
>=20
> The 1st solution probably makes more sense because we are going
> to remove the CON_ENABLE flag in the end. And even the merged
> patch is small enough.
>=20
> Best Regards,
> Petr

