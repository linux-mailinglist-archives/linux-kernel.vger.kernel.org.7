Return-Path: <linux-kernel+bounces-773430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22762B29FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2297B47E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A312765E6;
	Mon, 18 Aug 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qj5+Ol+U"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74F156F45
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514908; cv=none; b=EpXDzzhpT4fPYm4m0F+eg9UOqyemXdjbhfeCl+NuMUts9FcdOFh8lvyEDy7a9dQkURoZJn175d/8MAH0ThHxiba8Chn4UT3iOgQuGm8ZvS8CHZNIFq9ZKxlPaM8pnHEUqbhpGrD2cISuKmzU/2JH3i7O979vd7c/Ga+4H23BtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514908; c=relaxed/simple;
	bh=9TYaT7DVhh4RqpRijSCAWXM0qbM6HEJ9pElNlwj1hzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4RG2wbkrT/ka0RbBLi5yZ8iCJSUg1DZ8lo53w2g6UL7yxWj/fuxptd88iH8ZmqGqi/HDVH2eTno1CmuzgIJAq1HKspRGzCPfPtHeB7vWcc9Nz3jJtdcZrSGgwrlm8zTRrzgIqjuAUJ7c5Rx3q6SxBAj/4u+rzSB1BJnVD6vZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qj5+Ol+U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso21653015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514904; x=1756119704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntD9YtOAPnvdnrNXErbVg7euDwQgc63GGgL/mdtMZt8=;
        b=qj5+Ol+UOphHbjBEI+W6Ame+zM5ilKmkO+tR1eRCQcR17JdDFiRLG/EAalWvPkquKm
         ZrQ8Pvs3uNkKPfjCRn47FYIelUdVnoNVdkNZU6YQa35Ran90BKvnRXxMT/fYypXaat5w
         l7eezaXcEGUFOt6JcRABbVHX0LW3EFdbjxCj75LIF+OrE6GLA2fRlzfzsQfOhv/4csOt
         XeUe/ImDc+atJrzezK/723DBlAUB+EQOjNJLZcxXmxF2v16iT8jR7pSBM4vvpxh03Yj+
         J2oMQjWC6ztgtWAtl+Q7WbLFWi3D5LTlaxAw4snOcZcEeBMEa2XdnlhWX3E0TzmVh6tL
         2y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514904; x=1756119704;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntD9YtOAPnvdnrNXErbVg7euDwQgc63GGgL/mdtMZt8=;
        b=OtgooKflJeRHHTxxj7lGhhrxxCIgoKfAW/GhKNuLDAWs38nPmRCdtZf4VUp1G78Q7F
         0iSez4G4qFzaSpshAeXXotTNrONYZcNltuHoe3w0l/ePfornW+SQj+SAxJtiiHKCgj25
         DhDxowtUShOk60TmnKGGyRY5fufQZc4ARUD1EPLHCM2wzBLqdlC5bXAtlsoOcq4+ZYE9
         4By25iDDg4pZ1VgJKhzcxqOijZKYAZugPj4hCnmSXEj+3ZcLbxfabfwLDnPWW02p9So8
         8XNMfnAlB2dD20AV53zmw7pzrU4m9+0GpEZxw5xYTzTzOM0OuWap+YK+EWjB5sMq84//
         ERMw==
X-Forwarded-Encrypted: i=1; AJvYcCWbaMC15jGfwjOSaADQUlUtivgj7Y7XfECLu27Gl8a9HBYThOXNH3DxdvpGdSoTNef5woRrajaXUtTyQVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzrcjsq4fGWB/YjWL0/GiQKzBWCyjCM445MPOwDuyef9OZJ2d
	d5Hxw1izMWl2aDCTnwWI48xJyP4TkL1DLXl/dXlzcevrcknSMrri34ThA7XYjRLTI0A=
X-Gm-Gg: ASbGncuQgR+H5wOfRBa1hWbdjM6HKqibpbUZoIOAmlaexGZc9d/WNuQX+ivNHPI160z
	ApeFMkbaBj5QBkJ3JZpTV533fppB0rTCioRS8a/7IdG2kosk/8ZKYXM+hmeb99WJ46noGfGBSHb
	6RcBQ3UPATzRBZwwWVgydOluniRgprRvNZR4qq/Qgwewb9FNyQLBlRXjywUaNTf33J4pJ5fLI8G
	uwH1qWI46FDgERYGsVscSpoC+g8J6PVYibql/+sTXpedRg/T8vIuUBsrCP9JU0E2wUO0qcPHUpO
	VQK9PDuRs5nUGSc/S1nJeo3EycTnOa4OetRX3Zhz9HWYN61yKoFO6U6XSL1n0bbMkBm7DuJwH2Q
	hXcEyEHECKSWocm5bk4Zb7uCl2mILvWPr3hKI74LVGCB2dsa122xfqRdPHYq5trat3A33/xBIFw
	==
X-Google-Smtp-Source: AGHT+IH/1MJvqzbVWRStZFWheU1Jn9W/zKSEPXOg/a1tWJXWqxadFZwQAV4W2k4siiejGTbxIOR40g==
X-Received: by 2002:a05:600c:3b09:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-45a2183d324mr86473385e9.19.1755514903882;
        Mon, 18 Aug 2025 04:01:43 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1ce9758asm165995675e9.15.2025.08.18.04.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:01:43 -0700 (PDT)
Message-ID: <61f9767f-ee4e-4f93-b84e-59ccd422c98f@linaro.org>
Date: Mon, 18 Aug 2025 12:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix firmware reference leak and unmap memory
 after load
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250818-iris-firmware-leak-v1-1-1e3f9b8d31ce@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250818-iris-firmware-leak-v1-1-1e3f9b8d31ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2025 10:50, Stephan Gerhold wrote:
> +	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);

You're not using the latched pas_id declared @ the top of this function.

With that fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

