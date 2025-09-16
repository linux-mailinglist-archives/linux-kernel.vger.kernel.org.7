Return-Path: <linux-kernel+bounces-818219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE544B58E59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7455E1B23402
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77B2C21F7;
	Tue, 16 Sep 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cby3wWqG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486E22D4D3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003513; cv=none; b=MAP9baDqlMJt+hW/GbqBL5dW404MjwKIuH+LbsaZ2FXZPNdwUnNbkwbTFsOCl6EFArlTopuBTYKUwEN5VuBBt1vtdRiph5U8Vvd1y4Ds9LWBa/yilRelRXmwqacXQuqODHyL0Ij7nP2/FCN6Y4K+9eytAX+XTtiGDgex78UCGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003513; c=relaxed/simple;
	bh=h0oy1I8vUQDsZmPFSFL2SHlXobsxf+ZzePpRjKgyJRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J80mONNwzFzR+Xnin40I5trWEYfW0eqBz/b+ybJ5pIPtLjU7aSSnlspFdgiTR3DAVvbYnaqy7zUI9H5ak2DGh/wz5aVKMwRvCCZGwGGUHzV4UzH/XpBE1RUgZYsnYyKzZbrE6Tk328owvj66bBevHMR+Lv4E1zxwD+sBKXh6HZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cby3wWqG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso29988495e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758003508; x=1758608308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yE36FkE2n6Nf6sdtAOUC4xWShp56TIuhQU2XNORUnm0=;
        b=Cby3wWqGtQYGaWm0b13zAGUzxyQkcwGFOeqShuOBx3aQBVqaHv+d+lWDD6xiQxfFXz
         RNlbInju2A0o9FODeVnphs6trUmhFDxLwUqeVMt/l/72oy+fBDjqSQrxWeu5GFU/FmVP
         XAaSaGw5sJPiDxc7XD7BlXtHTSEqRtAIUhKQZBiDK1ChfrEB/Who+gsdO4dVKlzei4Dj
         xl4Nl0asUEInVfz9/i3EcHX26T3S7AvjcpOpEj9i8SMrB0cmCiNJWhJ35OqMEFlNd7vT
         nl8NwFaFxB5iFjpgLufAxh0yvDOzgpDe9aDY/jU1LD7WwFru8nHgQP1QMBNe623FA4ag
         +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758003508; x=1758608308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE36FkE2n6Nf6sdtAOUC4xWShp56TIuhQU2XNORUnm0=;
        b=ptUEwSB0PiEqk1HpFbpxfyOtfLGgSQjmR14IOsuXxsgmyQy2szNHQQuzfXWCX39kn+
         ArqYbyzbFMW5kWTikvjPBmKCxhIR1hfFHKdqP3RAjND4A+jhmS3MtuqKzz1y/s5xA+nl
         4o69GxcMxrbNvynruFr7CfkUvU2xqY72k34cZtIjcnzf1gdB0OyMyFr+H5vcTEQ6SL4X
         a0IJvO+i1WU24uOY6RQL5pziBjnz7TvfvEwI+5a6EryASFFxfJmv15/MbYnTZVW4x/4I
         4LrTERu/kVwefrunfiHCrvH5d+EproDkYFZ3OP+CYp4i1F6FL+/7RvIsy0gHrcAStZ0g
         Bhpw==
X-Forwarded-Encrypted: i=1; AJvYcCXcm86T5B+B1kCoczAxDXDjRX313A4awFWG2MqhQcqLDKFTHBCtYHdmj4YIncIQOzfsB75PbHqgUzyEolA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAG1YgeZhZxVCXw940qYELqjD4SVh7ZmCfawvVVtzcIDxhjvbe
	uAa+UMtofFMMPck8vrCS2sKFbm3vaDg+1H/D9xw1io+KkfQcWw23BbIpb9vJXYsU3Ls=
X-Gm-Gg: ASbGncuIs8SSLJdD+YfWyqYKjt/ICcXVOW8HRPR0WT0USZrKBDtOerY6zmdiMciGuXo
	D+YB7YP//x24A8Luj0DPCJwP0zpeWWAX5lxOuDthskS4M2f6poX9pW7qVeXTz+aSp0dBjoBrTev
	PJWTq/puwU+MNceXYRaJQ+NpS1/wKCg2q1YnA2jYmUnuITkt6t4uwGdZrRbPf3fFLSDRwHeHLTd
	1fgKvd8+jiTnefi0X2xG3EngKLq1wUmyzrVhK2B/8Q/bZhMobu1+kwVifedHNRCBu49clBL81CC
	JQuimEohuL+7P9ElVN8/2GDJ6wfN7NXuf8NOkTJofeGB1WnRDA681epkgBnNu4FWL6ElQBMOdhi
	BnXOX5/hfgHZZf7/+SuCG1xJg7jG+cOqd
X-Google-Smtp-Source: AGHT+IGcaZaJsKjIbaiVHIrRn4D20wudJAA8cvj0MPlUEtXe2fB7JX4ecViL1+EV5ZvPuLWEqJHr3w==
X-Received: by 2002:a05:600c:4454:b0:45b:97d9:4127 with SMTP id 5b1f17b1804b1-45f211e53femr132015985e9.1.1758003508477;
        Mon, 15 Sep 2025 23:18:28 -0700 (PDT)
Received: from [192.168.68.105] ([91.116.119.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5cbcsm211728785e9.11.2025.09.15.23.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 23:18:28 -0700 (PDT)
Message-ID: <a6169ca9-51b5-4ac7-99c9-e8be695d831c@suse.com>
Date: Tue, 16 Sep 2025 08:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/boot: Add missing compression methods to
 usage
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20250915153114.40578-1-antonio.feijoo@suse.com>
Content-Language: en-US
From: Antonio Feijoo <antonio.feijoo@suse.com>
In-Reply-To: <20250915153114.40578-1-antonio.feijoo@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Error on the subject, I'll resend the patch.

On 15/09/2025 17.31, Antonio Alvarez Feijoo wrote:
> lzma and lzo are also supported.
> 
> Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
> ---
>  arch/powerpc/boot/wrapper | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 3d8dc822282a..50607bc47d05 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -21,7 +21,7 @@
>  #		(default ./arch/powerpc/boot)
>  # -W dir	specify working directory for temporary files (default .)
>  # -z		use gzip (legacy)
> -# -Z zsuffix    compression to use (gz, xz or none)
> +# -Z zsuffix    compression to use (gz, xz, lzma, lzo or none)
>  
>  # Stop execution if any command fails
>  set -e
> @@ -69,7 +69,7 @@ usage() {
>      echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
>      echo '       [-d devtree] [-s tree.dts] [-e esm_blob]' >&2
>      echo '       [-c] [-C cross-prefix] [-D datadir] [-W workingdir]' >&2
> -    echo '       [-Z (gz|xz|none)] [--no-compression] [vmlinux]' >&2
> +    echo '       [-Z (gz|xz|lzma|lzo|none)] [--no-compression] [vmlinux]' >&2
>      exit 1
>  }
>  

-- 
Antonio Álvarez Feijoo
System Boot and Init
SUSE

