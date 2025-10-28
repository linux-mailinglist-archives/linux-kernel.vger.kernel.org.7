Return-Path: <linux-kernel+bounces-873324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2128C13B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B53864FCFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8412DA77F;
	Tue, 28 Oct 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR4yunoB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A392BEC53
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642146; cv=none; b=TlU327LLI2FxPkY79bwiUna2+YgjyX6sErxnMWy40dDTqJqaRz/zLpqhs+U0lywmJ5OosVzgXRXggRAgPEd+yOLptmlAswr2islBMOF9L+AQ34zN3cn2nzcDnrO3yeIm+F911XzXKx0x4OzLz6hRfy0sDACdjU+ybVFFw4WPMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642146; c=relaxed/simple;
	bh=K+XIvjGwAhafKHItCiqDzhO8w2fQiwJCC6KEGx4Lk4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyVQLeIRLGlOsuFMQd+F5aC51rkcxHYqnKe03N/2DUbTGS5bm09zrP5r2DPD+WyLzbKGJiLGpN3aNH9AEcYq8l8asu9q4mGyMF6afQM1T8yJ9u3fI4gBIm2MwpQ5DcvwXotKsK6AWUmSwV026iEBY+PViHim6F6SnpGTLbOtU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VR4yunoB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761642143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM05/jRXXBYsYn0Ee/zuHF8a76j5Ke84+LpUeLrwUuw=;
	b=VR4yunoBz38yEhTKc9Zxcw7fp6TvoNFCOSpar4Nd6mYvdYTO6A4t77+LZg4fHXqzYTRWPO
	q1Zi7qstgqsg3zAoXT++ILiaUuw9+I9XsF2M9fJTUY8ALoB+LO1MUbVFwAjR2/sYRzgaZW
	TY+qlw5TiIuakU++ByVNUJuxirK0r+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-UVXD-OSaNA2hV1TBEgQkgg-1; Tue, 28 Oct 2025 05:02:22 -0400
X-MC-Unique: UVXD-OSaNA2hV1TBEgQkgg-1
X-Mimecast-MFC-AGG-ID: UVXD-OSaNA2hV1TBEgQkgg_1761642141
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477171bbf51so4312545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642141; x=1762246941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SM05/jRXXBYsYn0Ee/zuHF8a76j5Ke84+LpUeLrwUuw=;
        b=AysAQGaJj+hV3ccp3UC6tiMQGwx9hIq9vfw/F8pXrIR98kHSWe9FjvEggFWEhs45pH
         XMZTS/zCv6V1scWtlDEGw/t71wMrGuGpMlyw0mdCq2Uh8hxuerLcx+3hNIrGdQi/H0eI
         /DJwTKBROWF8SjlYipQMctanG7+8QD+0W3aesIZQsvCoUgRUE06hvojz2aCCfYzZIkkB
         EdC7jL9lpc17rWHgnYkMDBnfDnip3+8g/lWMgXtblCh1WfhlaJzrBVZ1HGL+H1s1HmXv
         vjIdDN29zinSygg3gXhm8NdyaBp+yl49f7txObt3aMuWaor1bXm1YOliMToyuTW4zmwt
         fBTg==
X-Forwarded-Encrypted: i=1; AJvYcCXGXvsplwDXEt221p8WsEAl3Ew9eeHvSQrs036X7h0RmCY+M5w+RaaAS1U/gvvBR0E5UZ/AfTLS7VR5jyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkJrzGfP7Fqdg803V7wD+DhrvoXCy7ukcxXcip0eyWI6W1aq6
	SpzTezctIFeo+tFJZk9ZXWmfUbicqPTTW/t6cgiuk5eQBGjl6SatRl/hEToiO69awr7KdFNUHMr
	AM5U9ZG8I8xnSay5/eBp8VhSeuGQlT9MQ6185sHMRklrv4NBD+q7DKpIB53tEyRHROg==
X-Gm-Gg: ASbGnctgEmN/ceXckZsmSkkXo11s5lPlQjvandQKxtGIJ2HAvVNOnDQMGXSsbUiVlq7
	NKoTy7nLJ5n6QiSoqLvsQfw8VRKthLBoI45Yev4IfXm0F8eBbgfR1ZUAUP9c9nupTtDn02kxrOn
	tLUZmEGHWKO8tqjwuvIbySpzfTTMLS9D5WPLrgb0QIJ2MEgEkdMCs8I879kbzEH/bSuScVlp06B
	yXxRiq5ewvq83ABZ67QXxq4nDNgNtR5h01MlrPkRRX4fndd4mU7Cx0zyQVD9EDM2P+xMQ4kqJOR
	RXa0N1D+JBZLtA9iBAmt9ntRUZvCLTElHBrJAODJv88LsHsJD+DwvHzPZdECj+MLVqRm8PV53Qf
	Zak0XtAsbbwGRS3okvKdyvBbWQyN0oS5/i+YB/Djqq+nXv1I=
X-Received: by 2002:a05:600c:45c7:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-47717df8103mr25596775e9.8.1761642140903;
        Tue, 28 Oct 2025 02:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHagBoGdK6HupPPgFH0PFJ3o2Bp7w6V7AVH9KHPBJxphqC148YxWSmBSskq2/Z3uCr0SXEhlw==
X-Received: by 2002:a05:600c:45c7:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-47717df8103mr25594805e9.8.1761642138824;
        Tue, 28 Oct 2025 02:02:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm19115071f8f.38.2025.10.28.02.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:02:18 -0700 (PDT)
Message-ID: <d4c31a2f-590a-4b83-b6b3-25f33a51193a@redhat.com>
Date: Tue, 28 Oct 2025 10:02:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] psp: add stats from psp spec to driver
 facing api
To: Daniel Zahka <daniel.zahka@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
 <20251028000018.3869664-4-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251028000018.3869664-4-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 1:00 AM, Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Provide a driver api for reporting device statistics required by the
> "Implementation Requirements" section of the PSP Architecture
> Specification. Use a warning to ensure drivers report stats required
> by the spec.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  Documentation/netlink/specs/psp.yaml | 55 ++++++++++++++++++++++++++++
>  include/net/psp/types.h              | 26 +++++++++++++
>  include/uapi/linux/psp.h             |  8 ++++
>  net/psp/psp_main.c                   |  3 +-
>  net/psp/psp_nl.c                     | 22 ++++++++++-
>  5 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
> index 914148221384..f3a57782d2cf 100644
> --- a/Documentation/netlink/specs/psp.yaml
> +++ b/Documentation/netlink/specs/psp.yaml
> @@ -98,6 +98,61 @@ attribute-sets:
>            Number of times a socket's Rx got shut down due to using
>            a key which went stale (fully rotated out).
>            Kernel statistic.
> +      -
> +        name: rx-packets
> +        type: uint
> +        doc: |
> +          Number of successfully processed and authenticated PSP packets.
> +          Device statistic (from the PSP spec).
> +      -
> +        name: rx-bytes
> +        type: uint
> +        doc: |
> +          Number of successfully authenticated PSP bytes received, counting from
> +          the first byte after the IV through the last byte of payload.
> +          The fixed initial portion of the PSP header (16 bytes)
> +          and the PSP trailer/ICV (16 bytes) are not included in this count.
> +          Device statistic (from the PSP spec).
> +      -
> +        name: rx-auth-fail
> +        type: uint
> +        doc: |
> +          Number of received PSP packets with unsuccessful authentication.
> +          Device statistic (from the PSP spec).
> +      -
> +        name: rx-error
> +        type: uint
> +        doc: |
> +          Number of received PSP packets with length/framing errors.
> +          Device statistic (from the PSP spec).
> +      -
> +        name: rx-bad
> +        type: uint
> +        doc: |
> +          Number of received PSP packets with miscellaneous errors
> +          (invalid master key indicated by SPI, unsupported version, etc.)
> +          Device statistic (from the PSP spec).
> +      -
> +        name: tx-packets
> +        type: uint
> +        doc: |
> +          Number of successfully processed PSP packets for transmission.
> +          Device statistic (from the PSP spec).
> +      -
> +        name: tx-bytes
> +        type: uint
> +        doc: |
> +          Number of successfully processed PSP bytes for transmit, counting from
> +          the first byte after the IV through the last byte of payload.
> +          The fixed initial portion of the PSP header (16 bytes)
> +          and the PSP trailer/ICV (16 bytes) are not included in this count.
> +          Device statistic (from the PSP spec).
> +      -
> +        name: tx-error
> +        type: uint
> +        doc: |
> +          Number of PSP packets for transmission with errors.
> +          Device statistic (from the PSP spec).
>  
>  operations:
>    list:
> diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> index 5b0ccaac3882..1aa3857a85c1 100644
> --- a/include/net/psp/types.h
> +++ b/include/net/psp/types.h
> @@ -150,6 +150,25 @@ struct psp_assoc {
>  	u8 drv_data[] __aligned(8);
>  };
>  
> +struct psp_dev_stats {
> +	union {
> +		struct {
> +			u64 rx_packets;
> +			u64 rx_bytes;
> +			u64 rx_auth_fail;
> +			u64 rx_error;
> +			u64 rx_bad;
> +			u64 tx_packets;
> +			u64 tx_bytes;
> +			u64 tx_error;
> +		};
> +		DECLARE_FLEX_ARRAY(u64, required);
> +	};
> +	char required_end[0];

This makes static checker unhappy:

/home/cocci/testing/include/net/psp/types.h:167:6-18: WARNING use
flexible-array member instead
(https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

I think/guess the warning could be avoided using something alike the
following (completely untested!!!):

struct psp_dev_stats {
	struct_group(required,
		union {
			struct {
				u64 rx_packets;
				u64 rx_bytes;
				u64 rx_auth_fail;
				u64 rx_error;
				u64 rx_bad;
				u64 tx_packets;
				u64 tx_bytes;
				u64 tx_error;
			};
			DECLARE_FLEX_ARRAY(u64, required);
		};
	);
};

// ...
const unsigned int required_cnt = sizeof(stats.required) / sizeof(u64);


