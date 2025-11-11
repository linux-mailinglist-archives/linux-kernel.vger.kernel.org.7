Return-Path: <linux-kernel+bounces-895856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A3C4F1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54DBB346A41
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55D1D6195;
	Tue, 11 Nov 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="V6vmHzIZ"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485E3730F1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879926; cv=none; b=PVQ9lKf8/AsT1UP1eUCEpIvk8WJvgovdkS/UuS0I7PEyvt9EHIbDkfo+IkeL52mxJzFg65XDsZHaxewPMQMFg4oMqU30LaG4PDV56W0qeNvoXUe4inRlw6XrKcdETLQ8doGi4silQpihwFyXERONRm3RmPkqu71DzP7Ypbir2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879926; c=relaxed/simple;
	bh=HEIC2usiTHdfW1IJriTA3jOrfNUiVWrInSNqYkPBaGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeXKMzrC3E9FRxK8B8hhqSgplL0XI5jWxiNrbglNypKglHHEXofAeEhYBs692QkO8CEfnVfSgwg8gQkVjwrt93k3FJrABEUrdL7cDLLsezMNzETk2VokJJjUswwc0nqEudVSeMh6ttogieNqBMxVrc7WQYLUcz3Xp/NYx1C3+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=V6vmHzIZ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88e51cf965dso537835985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762879924; x=1763484724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaNFkqsjr5HqJ0U2z2rhHc1IR4euaoELq+Vuadxi0mU=;
        b=V6vmHzIZ/0h7EG7IVdRdOaO4C+VQXmZpWkT533XH8PJbezQnyvbfR0oj+PHCbZgjYv
         MM3U9dyu0ZjiX15PmEwMJf5+JndnDy1GL3RKUR+8XIVMP0ibr6hj4nseci/qvvFxaDqK
         5VV0vdbPgLEaC498zwwEJUN22k87lH65Kc5805zrDSRMBwzZTSv1kftFRKcbq+3zF5hE
         0qP5TfYV390B0zbi8X94lENmZElkbGgjI40s+Hq/TsUn0ZX3m9XUhVspaKc2+d4V2Huc
         LE83yy8wrkxFyiyKxdOQrFSWnOuCzB/Ixk2uJRPM+pOOXEfemtiLVPwdy24UalKnQWJ5
         +4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762879924; x=1763484724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uaNFkqsjr5HqJ0U2z2rhHc1IR4euaoELq+Vuadxi0mU=;
        b=STn6a4kC2t8U99D+87pazGgW1xI07kbtOwbKcGwtQvjOqV3yFN6qMB5Ob7TUhHdP9D
         myL84r/KyyqzIJC9NWoW5tyzbU6AxMD0olG01ZXbi6WGQwlayEiy1UJBSuTT51eaB4qP
         IEuMEx0iBL3gnxmO50vPkM2CBx20rf4xaFdFLSbn6bN5NgtOB9USFzz0LPzKRXE5W5Z3
         6vvuNJJ5EgaPJqug3P3FI6pwq0uN494ivvj8ve6843xnUZQws096hcLGdpVcL5GDnci+
         bH46eWRv08wWr4t9ueJM/7C83E7PbFAIVBY7nQD2IXDxZaUh/ruPmDgfNGzR2BzhQ0IF
         g8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUXPkFNgh2nfytW/4nvb6tfdY1fE3M5Fh4jlFPzbJ3XYurEW4EmGE4pzrNUeQFfZDe+8ReUoo6obvvBYDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyChzNxpqC7Tkgm/m6uRsWU0Vk+J7CHoNGYyBtr778E8RRLVyAf
	MAgFKdcDdmD1hcae4Qq59YkIJCJu+tP0zw5ek2ukuwOLXXa+p1asHQ7ezWm7pviI5joRZF8X/9M
	DIXBiY1fb6VhLylg52Zg3RKmml6O6DTwM+B6g/3kRjbrJ7OV6olWNTDw=
X-Gm-Gg: ASbGncsT9xQO+mXwV8I4Ga4HfSaYvd4ScotWP/IPgUqYPkUjnskejVKwq0fAsMJATZd
	qdWBwGUDis48uZ9GsFlDJQIW43VHG1dRxYDc7gIPFrpJReNzhmBFhW47L2Zx0HxUrk5c4zQrLO2
	1gt0q4Wl7IavCwXSDUMw++nesVxKKl3Gbdc0Rh50dzNV1zxIsbE6BTI7txmUmsxAcEktUZVroqt
	eqQKK7fhKCuJ9LAwq7OG+1Fk0Tye6GKeepHOmLJlyZnLUUcb+Ig9Ulu0YRTgviAvc8yf6cINkTQ
	3qkkqAwMrbEFF7flpe0wDQYj
X-Google-Smtp-Source: AGHT+IEUkPPpBFSnV49PowujRgyHB8h3Cch3prLC6j+Nq7FI3gGEKIgq2OVf2cRR3rles90pF9EIZfNOPT3YwIjwQ28=
X-Received: by 2002:a05:620a:31a4:b0:866:a24e:2eb5 with SMTP id
 af79cd13be357-8b257ef5b64mr1620026685a.34.1762879923750; Tue, 11 Nov 2025
 08:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRHClatB48XT_hap@kspp>
In-Reply-To: <aRHClatB48XT_hap@kspp>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 11 Nov 2025 16:51:48 +0000
X-Gm-Features: AWmQ_bnpjuyUMlKXkIQGvaXCW-KCOwGvfQY3esE3go312vitsho8JRzN-sru6wg
Message-ID: <CALrw=nF_riH-aHJ6gpKBw59s0szrWhqT+QmdpYVH6d38Kc_rZA@mail.gmail.com>
Subject: Re: [PATCH][next] KEYS: Avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:46=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>
> crypto/asymmetric_keys/restrict.c:20:34: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
>
> This helper creates a union between a flexible-array member (FAM) and a
> set of MEMBERS that would otherwise follow it.
>
> This overlays the trailing MEMBER unsigned char data[10]; onto the FAM
> struct asymmetric_key_id::data[], while keeping the FAM and the start
> of MEMBER aligned.
>
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after the corresponding structures --no
> blank line in between.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Ignat Korchagin <ignat@cloudflare.com>

> ---
>  crypto/asymmetric_keys/restrict.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/r=
estrict.c
> index afcd4d101ac5..86292965f493 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -17,9 +17,12 @@ static struct asymmetric_key_id *ca_keyid;
>
>  #ifndef MODULE
>  static struct {
> -       struct asymmetric_key_id id;
> -       unsigned char data[10];
> +       /* Must be last as it ends in a flexible-array member. */
> +       TRAILING_OVERLAP(struct asymmetric_key_id, id, data,
> +               unsigned char data[10];
> +       );
>  } cakey;
> +static_assert(offsetof(typeof(cakey), id.data) =3D=3D offsetof(typeof(ca=
key), data));

The whole thing looks a bit convoluted to me just to declare a
fixed-sized static buffer and call sizeof() in one place in the code.
But I couldn't come up with a better refactor not introducing
potential alignment side-effects. So LGTM.

>  static int __init ca_keys_setup(char *str)
>  {
> --
> 2.43.0
>

