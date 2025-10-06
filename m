Return-Path: <linux-kernel+bounces-842638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DABBD36C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 085623490BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52519AD89;
	Mon,  6 Oct 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EF9jBude"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528961DB12E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735847; cv=none; b=kjdtjq+XcDQl9DxVQTmLIcgq2HLY8a7kjocJDz1dWc2cG3t/acX5XyJXCm3N9bJKDGtP+sy5PRhBZxQzvK96sco6epIGeVLDifjMUMbzyj1LOdWxCdZ6INjhA2+7uGfYFlXDRS4029+cbiWZ80T7nA3DlGOwDx6iZJWz1RVeg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735847; c=relaxed/simple;
	bh=TBDr1JkUT7j9KA90UWXW3NvfyrgaBEzv+GFyFGVZBkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEoOJPQwSZgucf6HPh+N++LMg7B/0zlFW/LBg7sbA1Yr5khrUFoBt0ZPI1mp4GO9GRp/Z2pQ6+lGnbJ8MoS1HXs14qvr9zNCQXtyUAW2MuUrFTsIe2K6Mkso9Y/K9xCeam5nnbPwNIJhjYLrIPfsde9qY0SMGtkENrnWKBFwmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EF9jBude; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso36253505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759735844; x=1760340644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8kZL0MExGW8cJG6gQr/1Hyxz1bR5ca3a5nlWTrYorQ=;
        b=EF9jBudeKbLLqTowLFYqinVVcJL/5ifuPLXcW43J0TCI41as1CL4yvOBKcH3JT338v
         hgHQVI34NkHH1kil9RS25FSsvpkFmY8jzOQKIG2t56hsFx0MO5plZLdlWJJ+43KI1X71
         4QlROqIlOcp8RqtUHz+llJ6gRRh2LT5uRGFpnfDLrRxKwhAXms1ONmZvo8qcJ2ccVsDE
         NC2a4V9f97Fgka/geXVAE775kYOjjls9nSEVi29fS2xNNa0zDReiQMX0iOGKPFw/PjPi
         L4CIycGNL406rdHR+JiMyiSbSbqpxHienBj7EwsYnuYi4BufyTZUpFtktQtggmOiQsXB
         FZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735844; x=1760340644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8kZL0MExGW8cJG6gQr/1Hyxz1bR5ca3a5nlWTrYorQ=;
        b=ri4L0szLw5ZsUzrVDZpA4ZLrW1IOGEPLgDaYNiSjPEtTHh5JqcntckmJan4PxQhxpQ
         BPjgAxpYUy6w1rLL13Wdd1RZaJJva0YJSY8bAnFru7pyYumupI/snAkL3lJxQRNDYCRn
         6W/OgpMX3HBYOZtxXCmFXYtyN1Gi42l6xaQpAhJA/46I9eFTKcuY4CEL/Me8ecjKcEbu
         z1vurcTNrH2vvmr6txBgMGeAnV8GCeLG7DooXkFpDdmEzzC/gbFop/IOyTnJr4KkdhCR
         UE6f3ivoOfL9zpPNAc7YBA29klv5t1b+X7OPfP8YVtZf8wgA/JtuQY62bF4btXjgfYkm
         tR6w==
X-Forwarded-Encrypted: i=1; AJvYcCUYPcoeqC8WcQpjCrtzSq/5WFj12nJ5GwlNajwCggzfmt2YaeAK5BO/72n37blnE0hgZuC8un+rSF0If7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0R6Bz6ZSaGQdR77mL+4jWm+L12Erdg2WWYhGhWChh7Dqmuwgo
	gVBRk32ICTQr8N2u48aZ0oUSGWtyKxFK7G5tN7EUITH8Q60ISpFW/8jr4JXHItBnU98=
X-Gm-Gg: ASbGnctwgZ3J54S9cy/YsYoeZ3S1VhajsHuhxvTV5+CCwOhz2Da17JlWzPeud170NGh
	lL4kFZYzj3hfd5UjogUqd98suLtvMaix5EwxM8E1EAW8oXCJxcZ6AiVUAgclvJUGGK9Lubqr07c
	EI+eJ7OXfLjWar4/21Y2wRJ+h1EsrDeDinHl6KXG2VMho3SciWo5M6cCgsqrkigKfrced09zS9r
	cLc4W3CJj+3iE8xBHZArve1fwKAAE1KPOsjKHT9NmMy3gEhB7Y7KbilosUiS3kwVgKlgH+rYZsn
	cTsV7zHzY53889+65il4Gnj3aHfTd4llQ8+WeoKCPxe2dVHpkwsu3eseTd72sP3AXXie0c80LvI
	GFq9cG2T1WlmPsJqtpMjRjhTADvStzF/Kpp4Rz8eg56CYZFTHX1aed3/4
X-Google-Smtp-Source: AGHT+IHlOl2o7J8oMg7owJ/UrBP+e3/x+xwXFkznLTXKMFB0/ZI65WuJDoEuRKi+Em58b6h4EIYQ3g==
X-Received: by 2002:a05:600c:8b42:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-46e7113f6f4mr71678405e9.23.1759735843524;
        Mon, 06 Oct 2025 00:30:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e72374ac5sm161158365e9.18.2025.10.06.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:30:42 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:30:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rohan Tripathi <trohan2000@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: rtl8723bs: remove unnecessary blank lines
 in rtw_ap.c
Message-ID: <aONwHi09P9VDTd3G@stanley.mountain>
References: <20251005155920.381334-1-trohan2000@gmail.com>
 <20251005155920.381334-4-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005155920.381334-4-trohan2000@gmail.com>

On Sun, Oct 05, 2025 at 11:59:19AM -0400, Rohan Tripathi wrote:
> This patch removes superfluous blank lines and adds missing ones where
> appropriate to improve readability and match kernel coding style.
> 
> This is a coding style cleanup only. No functional changes.
> 
> Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 2c906c1137bf..dddb02c0f683 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -438,7 +438,6 @@ void update_bmc_sta(struct adapter *padapter)
>  		spin_lock_bh(&psta->lock);
>  		psta->state = _FW_LINKED;
>  		spin_unlock_bh(&psta->lock);
> -
>  	}
>  }
>  
> @@ -1240,7 +1239,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  	}
>  
>  	spin_unlock_bh(&pacl_node_q->lock);
> -
>  }
>  
>  u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
> @@ -1974,6 +1972,7 @@ void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
>  		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
>  	}
>  }
> +

This is adding a blank line, not removing.

regards,
dan carpenter

>  /* restore hw setting from sw data structures */
>  void rtw_ap_restore_network(struct adapter *padapter)
>  {
> -- 
> 2.50.1
> 

