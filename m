Return-Path: <linux-kernel+bounces-879917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE1C24661
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8665A1896EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0835337BAB;
	Fri, 31 Oct 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uoan2qzA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEBD337119
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905696; cv=none; b=Lv66zYObTiXhRCsEuDWT4+NX8/CNy9VEfqaB8gnlXOW/NocSIqoNsyaie2Db/7BfrpnEn27VqcUhLx91kXO4f/Ni6fMXxpCp7P1LShZoMl1T+NAimkchub6bxCiPKgmgRl3VlnoG8Y4FaTgFetiN6rXxZpW7ENs0tlhOlCJ79VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905696; c=relaxed/simple;
	bh=leEyrcaxgVEFoDQpBRQADrzJ7aEgLp4CWlT8ZId/kkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQIkp/5K1hMATuOFeWd1DhOSYP5+Yiy6L26NxnGNdsVdUw7Buk4SDTvEu4XLbM8O+Juz9WtJD5gSBWXi9cGOn9oqB7fW9YO7X087NoAHmWgPTTpGY9WiIkmz+LCfyEl4uuEfu5FNIseDmuxSUdQ6SnOcIbJDNB2wc0lQmt0wIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uoan2qzA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso14578915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761905693; x=1762510493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTsftEfXvbhUS8zh5vLZ13mZZSic/SfiK4lQDUBWE+o=;
        b=Uoan2qzAIBNrasQ9kywQFbN58IyeAMjIUhAaHttS3uk5y3cip2mZ+qcszej6OEkUf/
         k3+fZLHyGSajsYormDv6TLbhE7Vb2lJyXGRT8mksQP634NpaSDlE5g2+pO59zy35vHrH
         7waG3oAol0tnP5Nt89PHg5c04a5brwVTpCPCFhOwUIzAwxmRTUqXYY3kbGiHDF2USN7c
         xUcSBeWgoyrggWoYcVe8A90ycN7Bz45yxQwlp35FgTKOaKLOS6LELPSK0qePRigT46sl
         83nXJevCKPl7+uStM0sJygXWYrDyFbMKmLldCqt6P0oYgstmHfmRcBnHdnwz1oo2e6eE
         m8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905693; x=1762510493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTsftEfXvbhUS8zh5vLZ13mZZSic/SfiK4lQDUBWE+o=;
        b=X0kr8LhBnXhGi3wZHEtVIVtrtkeeaV0G1+f2ks/lz8HV6/WEsQY/ywC3jVl2RgElQS
         Bm5rm1vYSuNvo8X37nAJ7P9Xs5e9b6QKFTO16jOW5qWiw0tUw5O0PacLuOn0N7XuZY9w
         E6g2rc1Xf7OnAtZcHzA/XoQF6kVqa4in8+cYjZFfSIVW7syZL+kGNZ8R1waQ7mEiO9+E
         S8s5sDlPpKRvbR1hxGqmLmP9DBqXOd4uTDURf/a1vRfhvl6eJwvBqprlQlU+3fo72JKi
         4bNtya1NjNBYmOz5bB3FFkel/1HdqnSnDj72NKVh7AOFiV5JbgpUv2Ww7oaxvgQGvubM
         HmpA==
X-Forwarded-Encrypted: i=1; AJvYcCX9hp1A67EGZYf29CG6wqq9uI6wX6WEenCvYRng3iaZ7gpk/ezYZMVhv74v8JivU+EnGaChT+8qPkT9q4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7G5JVJckIFH8lgmyi1qvX1q4eNCRDu/PKk28yGuQ2Hn5WYUZX
	UV9WvGzaGghBglFEO8WiUDZvy0PSU5tTrPdsdV7Dc1x9FeMWRvqCrMroVz3mVgw1hpg=
X-Gm-Gg: ASbGncv38q0JuJo4krSCpp1ULXjiIKr5AtLPi0XzQNR7vAvTimo/80dPQJOzU+kJTgK
	xqJnYC/+qHobUt4/IsvP70ZgTFWhJ0OklEv8yaP70XGcE/jSgM00/Fvoq+SwqKUln/yXa/o+4N0
	jGb5i0slCfjjjaTMupY+iKNy6HM14OS7lXvzWoUBZLi0ptupnhbOyaaB7LX4psDKtBP6alP+I+x
	Xa6Qy1nto4zHgjmGmYTVVdlVzUQ+M5gLPLjdNs5oPcbffr8O5ewc4KqDSjnmgoj1OLnlaz5frN4
	/ndT0V7uwdpacLbRnO7vAURdY3cGvskGkIhr8YxpR3qUkHHsspOzY9TBtqW8qIbc1nooDAJZdSL
	0SLfzKucXR/ffgDAisRasOvq42ln0ratc87AfTyrxYBbiCg1hR2R8+sqvwIXHUawd8zwV+i+2gJ
	fs+VYP5pU=
X-Google-Smtp-Source: AGHT+IH++F13KCtDM5aSmxXlRMY+DkOrtWxUCdzt5Pk2VSvn5xyt2ZqvsBCxug2ep0v/e7g5Vvdu6A==
X-Received: by 2002:a05:600c:3d98:b0:475:dd59:d8ba with SMTP id 5b1f17b1804b1-477305a35c9mr28731235e9.3.1761905692770;
        Fri, 31 Oct 2025 03:14:52 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c11182e3sm2792046f8f.11.2025.10.31.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:14:51 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:14:50 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: tcsrcc-glymur: Update register offsets for
 clock refs
Message-ID: <ievmorxn4cpwx3xnlr5m5j7tgv4p2ixfbgr5bojsetzmdgmid3@764lndl3yqpv>
References: <20251031-tcsrcc_glymur-v1-1-0efb031f0ac5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-tcsrcc_glymur-v1-1-0efb031f0ac5@oss.qualcomm.com>

On 25-10-31 15:32:25, Taniya Das wrote:
> Update the register offsets for all the clock ref branches to match the
> new address mapping in the TCSR subsystem.
> 
> Fixes: 2c1d6ce4f3da ("clk: qcom: Add TCSR clock driver for Glymur SoC")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

