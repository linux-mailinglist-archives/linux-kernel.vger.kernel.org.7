Return-Path: <linux-kernel+bounces-786157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D3B355BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCBB7A25CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273502D061E;
	Tue, 26 Aug 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3KkeIkM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC338DD8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193937; cv=none; b=FExKFxPmKj+1vMOHYY6XEAkWFiyLeCZ8PYbl2ITe9h70mmBeEfBVvJb/thWMoKfhTtlgcRbohO0/GJemsOaA7HKuSE86Gc+1EwJCTmJkx3BF8zHS0vpLEcZFtMX5/l47iReNDnoj/K2WPBqxOie2CoL0Xo9Y+Y49TAjWhiwASbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193937; c=relaxed/simple;
	bh=uP5dMqsHSqXNlw+qX5Xqd1i4XVlTxybaVEVYi61d/5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usbFcr1QVKel2WrYu5LourDxJJxYnwMvyXslaR2dZge1y/HTPtpGfG0Z5GBYSGOnWng5r+Zw1Qb3ueJJO+0JM1MtViq+ua0/JmxLSPU4M2TkVozM5GcTR95KgMIlaP3CvGHLDONJAgzKs5BoXPBtvbe+l8ztC38S4aCZS94Iu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3KkeIkM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756193934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/d6oLABXMDTE73AAJmn9nTIS3+npYIzihKgU/wI/Iwk=;
	b=Y3KkeIkMO+LSCtCd1xGxww4UjDwS3/J+dcnGL6wORA2WMrYz/Oz62r1wEivZ0Rj5Z5Xj64
	aP3zpabW7zNb/ZXgTgrgPuSjDF4y5jS47a+F20Ue/I0AzqoyZ0kNALn0y01h4d1U+x/U72
	aTM4WcrQ3AHEv2HgaLUoUpKOgNnpGiU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-X5koFsbHNbmTXZJ0WE-hnw-1; Tue, 26 Aug 2025 03:38:53 -0400
X-MC-Unique: X5koFsbHNbmTXZJ0WE-hnw-1
X-Mimecast-MFC-AGG-ID: X5koFsbHNbmTXZJ0WE-hnw_1756193932
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cbe70a7861so17758f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193932; x=1756798732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d6oLABXMDTE73AAJmn9nTIS3+npYIzihKgU/wI/Iwk=;
        b=nMXTqzabmLFM6WkGA+CnPhS7UVvpwpXnqFtFmxfipTynX4Ap7R+pKhN2b24nCTfLjl
         PhTjtDfa5MlIZfPUUZYCa2HndlmxngsYlbeespOOT2567aNT73gVYzkTC6Vc/QL9VuGy
         dB/U7RfFVVGU7SQYPywdyx/HnGonM1yfOQoM4LFY5l0q2QebH1RO8WOgaKCERJOwHCQW
         0PSQPYc0RUWEY3GZ7tWu7qYnMYF6XsThyegZ+oAgJCbq4YB7Ev0eU1Djm7y9zKI5jgkT
         MU47nHAcFBZMS0efWRjH1TcvmmtSNaaCvVD8wKS2wwyzREGwLTz0aD4HhwUSmCSnwKUP
         afPA==
X-Forwarded-Encrypted: i=1; AJvYcCXnhb5M2UeDg8XwtulH6MDWSXPSRWJg2e5sjcpWW516sMo6NCwc+JLQs4/YPNoAhH7hjqjcVnRVq4cm7Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmlA+ZJ6UHmkg1/SXqAczqbnFpO/Qee/Q1qFi2q1iMA1kGQ8AI
	Tk67lJU5R8oHs+25sCUy1zS8hxuHlEKdSkTS3/YUlMsRT2zS3bGdmlPBrrlhHa8FbLMjfjuSjf+
	hMsRJsmSzn4NfMC9aZbY4MZCHwhUvxGqgxWysIQil6Bu2+ywc1hdFoKsnjKUmLtKreA==
X-Gm-Gg: ASbGncstD3/KslvRioawASARC5xGHD8OycGG9OhRhshwISen4uL5G1G7IJm7EWmWn/H
	rdEfrAtcCrm6tIxySNp1OrsZ/WFhqNRbRgYF+GsA0aJg+TrfiR5qkTT7c/3E4yx8Lf5zkfT7/s/
	lD3veRx20UKnXrqonPLVS6J+bpSzkXh2svtkqpzbQgg+PchMbZvanGXwOOrAnhcvd08WQ3L/k/x
	Utysw+zJL5odgXsC3+EE9aGTLnvhiyThGf3z5NLLdLw7wo1dhAn5TybzKQaRZDK8ChcsLtA0OOx
	lbiEAxz/TYwcastGa8QtsKLMC0y1ncM=
X-Received: by 2002:a5d:5d81:0:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3c5dce05cc8mr11272227f8f.53.1756193931854;
        Tue, 26 Aug 2025 00:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHe+NtzZIdZcDMX+QmPMWtx5hDKS6iQR+ufYxm1cVDTFyfIzaA+q1XTB2lol3XvRHtPrWxGw==
X-Received: by 2002:a5d:5d81:0:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3c5dce05cc8mr11272202f8f.53.1756193931395;
        Tue, 26 Aug 2025 00:38:51 -0700 (PDT)
Received: from redhat.com ([185.128.27.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6133d9f1sm66813785e9.14.2025.08.26.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:38:50 -0700 (PDT)
Date: Tue, 26 Aug 2025 03:38:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 11/11] tools headers: Sync uapi/linux/vhost.h with the
 kernel source
Message-ID: <20250826033710-mutt-send-email-mst@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
 <20250825215904.2594216-12-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825215904.2594216-12-namhyung@kernel.org>

On Mon, Aug 25, 2025 at 02:59:03PM -0700, Namhyung Kim wrote:
> To pick up the changes in this cset:
> 
>   7d9896e9f6d02d8a vhost: Reintroduce kthread API and add mode selection
>   333c515d189657c9 vhost-net: allow configuring extended features
> 
> This addresses these perf build warnings:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
> 
> Please see tools/include/uapi/README for further details.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Should I queue it?

> ---
> * This is on top of the fix below:
>   https://lore.kernel.org/r/20250819063958.833770-1-namhyung@kernel.org
> 
>  .../trace/beauty/include/uapi/linux/vhost.h   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> index d4b3e2ae1314d1fc..c57674a6aa0dbbea 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> @@ -235,4 +235,39 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/* Extended features manipulation */
> +#define VHOST_GET_FEATURES_ARRAY _IOR(VHOST_VIRTIO, 0x83, \
> +				       struct vhost_features_array)
> +#define VHOST_SET_FEATURES_ARRAY _IOW(VHOST_VIRTIO, 0x83, \
> +				       struct vhost_features_array)
> +
> +/* fork_owner values for vhost */
> +#define VHOST_FORK_OWNER_KTHREAD 0
> +#define VHOST_FORK_OWNER_TASK 1
> +
> +/**
> + * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
> + * This ioctl must called before VHOST_SET_OWNER.
> + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
> + *
> + * @param fork_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When fork_owner is set to VHOST_FORK_OWNER_TASK(default value):
> + *   - Vhost will create vhost worker as tasks forked from the owner,
> + *     inheriting all of the owner's attributes.
> + *
> + * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
> + *   - Vhost will create vhost workers as kernel threads.
> + */
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
> +
> +/**
> + * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
> + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
> + *
> + * @return: An 8-bit value indicating the current thread mode.
> + */
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
> +
>  #endif
> -- 
> 2.51.0.261.g7ce5a0a67e-goog


