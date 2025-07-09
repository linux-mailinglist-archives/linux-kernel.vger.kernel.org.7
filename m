Return-Path: <linux-kernel+bounces-724307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39680AFF117
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA40542CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BEC23BCEC;
	Wed,  9 Jul 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVjM0iyp"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A223B637
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086746; cv=none; b=EeZpDD9lB9P589bU9YVSNOu4ef82Pt/jEOKrx3d/5QNMEyUzAvvMN1PPyl9Ms3260OKQxmdwBve/ZIJd+ElF372//QoEF5yUBjALJCyaGnqsfeDhRlVVnwBS+quo3UfmShysa2aWfDmpzWDhubK9MtKaSA0axvUhbEGmfeEz5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086746; c=relaxed/simple;
	bh=o2Srecg70C75Z0HRthLG9/BGvcwKUvr73fa64M/sWXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJIwL1JO/TAIOYXbd9it2s9kehjcQ/dwWldjcOp1+JRx/ErT27ZNE2Px/GFZW344gGSWZ+bTFzERI+TkqUpx8Ufy3OsKFlpd2wCwPsJTVgNfVapcT8sQoWXf3IdguJeBQo9apDLNRwcX+m74DxEVDytb4PebpqoT5TZHeWWOHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVjM0iyp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so3440445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752086744; x=1752691544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOErlnwQv8NggrVRfX0yyFZwivCXNjTKt1C2jEBasoc=;
        b=FVjM0iypNMDVOyrbFz3gIQPQJHorPesvMGwFYwtdbZ3OdR3QGww6Y7fpANEt7lp8GH
         t8ip84SuhDebHN6W4Zza1MzTsDLXvSqtJlJ3ES3CWSXR9xZYL0QZl3lpjPpt9LDt27bs
         5jWfXu/9I5TQ/zqWeRziqlir0fjSewkW/KBMjy+91+fj3iu6lNIEtY58i5cdvYzhocVX
         8PAwjG/oiJs+NszHk27m6IVEn6hTpwf9ePu0MduTDAIiy2QXNGUgVFeEhGW3Uzcyky71
         TTywwgmh0jdeGuRXXsXt36iinQsjEsNopKVQ7j+X1DQ70D6r6/y8dLfJtEzQ8DrwO8S9
         TIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752086744; x=1752691544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOErlnwQv8NggrVRfX0yyFZwivCXNjTKt1C2jEBasoc=;
        b=IKqFQRj/DmDhYkHjdvbE+88jV13sFUZTvYWZQ+b44sOseaiB+IVQxJ/1aBgTUnV1hH
         77A6EUg/sE3tKuWixUdzkVyA8ixeNrgwzyi3oTYluUqV48eUTzlJpmCfzRYPUENJdIXG
         a4FJdNeCDtBRYKgn0is+NOGuZhfiuKle4PJpcq2s3vLeH+r5gulVHmebjRmYOF+BgO6L
         dA8G0UuKbfR5olqHTLb9kIlPegtjVqlbRFs0XIUg6/zPR7I6KiBe2yK9kdQAlPvt2gkk
         DDRFSGTJrHqGlSbNOYGCmuzxm1c96qZEUALaE34CFtf+WSe7F6sWlGuBvUxOvsOQSN3L
         2mhg==
X-Forwarded-Encrypted: i=1; AJvYcCU6WEKK415K6vRBwNyCptg5OrxEi7ee7lQGR4IzcSJcYvF2ccBlp2mukTghoGYOKfUhI++0HN2qSIYwNb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnaA626VbnOxEdByPr8lruXfqcQHAbkW2fawbldNLJYTTs60t
	hYm3BhJnsON/aTB++2zMs6EpmX2xrpecPqMb1GWP+SIvvSsHjhSCYgxZAA8Ot/Znxw==
X-Gm-Gg: ASbGnct5Zd3XyguBkoBsXNTrTMogx2pj0dJDviXHu1/QhQLNz4oW9gN1xnDC0hynB5/
	EwHIUVyovMsnkidQ6OG9kR5KCCXZhpDT/Ck+coQUadfiYyXV8iZHL+QEIduubR6WeKbZbuTS2Wr
	ENG6b+LbJiwCWGQKu58j0zBuaL9PgIl6ecxqbT4sy0nmO5qEvtUfLUTBUZU01YfRzoaVKxh4O9x
	VJnRXyxwykcDoHpNyzNxMYQeND6aLzPmCUlq9LdhVcTtWnBaYJkVKh66RvzyJ9dwmqKme8APKB5
	HFEh5S/p6krEg9vANdWXUJUkneah0Y+AO2cQKvKCjBGN4jx/EvfeGRRVq7MbfdWTZOc+2pcb4ij
	YdwxGSO5cJgBULpcue/cSZGkJ
X-Google-Smtp-Source: AGHT+IHhHP8WC9J3/0rzpqhynsVgnNp0+YbSnGY2zXLovTWOTw/fE6eMRG6LuxgOAPf71XnOwcGe5Q==
X-Received: by 2002:a17:902:e890:b0:235:f1e4:3383 with SMTP id d9443c01a7336-23ddb199307mr49689115ad.7.1752086743316;
        Wed, 09 Jul 2025 11:45:43 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845820bcsm156142795ad.171.2025.07.09.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:45:41 -0700 (PDT)
Date: Wed, 9 Jul 2025 18:45:36 +0000
From: Benson Leung <bleung@google.com>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] platform/chrome: cros_ec_typec: Add role swap ops
Message-ID: <aG640KbIPP5hqSg2@google.com>
References: <20250709132232.2475172-1-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709132232.2475172-1-raduvele@google.com>

Hi Radu and Abhishek,

Thanks for this change!

On Wed, Jul 09, 2025 at 01:22:31PM +0000, Radu Vele wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> Add the pr_set and dr_set typec_operations to registered typec ports.
> This enables sysfs to control power and data role when the port is
> capable of doing so.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Co-developed-by: Radu Vele <raduvele@google.com>
> Signed-off-by: Radu Vele <raduvele@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/platform/chrome/cros_ec_typec.c | 77 ++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 7678e3d05fd3..289429ef959f 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -58,8 +58,83 @@ static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
>  			  &req, sizeof(req), NULL, 0);
>  }
>  
> +static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_role, u8 swap_type)
> +{
> +	struct cros_typec_port *port = typec_get_drvdata(tc_port);
> +	struct cros_typec_data *data = port->typec_data;
> +	struct ec_response_usb_pd_control_v2 resp;
> +	struct ec_params_usb_pd_control req;
> +	int role, ret;
> +
> +	/* Must be at least v1 to support role swap. */
> +	if (!data->pd_ctrl_ver)
> +		return -EOPNOTSUPP;
> +
> +	/* First query the state */
> +	req.port = port->port_num;
> +	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
> +	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
> +	req.swap = USB_PD_CTRL_SWAP_NONE;
> +
> +	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
> +				&req, sizeof(req), &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (swap_type) {
> +	case USB_PD_CTRL_SWAP_DATA:
> +		role = (resp.role & PD_CTRL_RESP_ROLE_DATA) ? TYPEC_HOST :
> +						TYPEC_DEVICE;
> +		break;
> +	case USB_PD_CTRL_SWAP_POWER:
> +		role = (resp.role & PD_CTRL_RESP_ROLE_POWER) ? TYPEC_SOURCE :
> +						TYPEC_SINK;
> +		break;
> +	default:
> +		dev_warn(data->dev, "Unsupported role swap type %d", swap_type);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (role == target_role)
> +		return 0;
> +
> +	req.swap = swap_type;
> +	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
> +				&req, sizeof(req), &resp, sizeof(resp));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (swap_type) {
> +	case USB_PD_CTRL_SWAP_DATA:
> +		typec_set_data_role(tc_port, resp.role & PD_CTRL_RESP_ROLE_DATA ?
> +									TYPEC_HOST :
> +									TYPEC_DEVICE);
> +		break;
> +	case USB_PD_CTRL_SWAP_POWER:
> +		typec_set_pwr_role(tc_port, resp.role & PD_CTRL_RESP_ROLE_POWER ?
> +									TYPEC_SOURCE :
> +									TYPEC_SINK);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_typec_dr_swap(struct typec_port *port, enum typec_data_role role)
> +{
> +	return cros_typec_perform_role_swap(port, role, USB_PD_CTRL_SWAP_DATA);
> +}
> +
> +static int cros_typec_pr_swap(struct typec_port *port, enum typec_role role)
> +{
> +	return cros_typec_perform_role_swap(port, role, USB_PD_CTRL_SWAP_POWER);
> +}
> +
>  static const struct typec_operations cros_typec_usb_mode_ops = {
> -	.enter_usb_mode = cros_typec_enter_usb_mode
> +	.enter_usb_mode = cros_typec_enter_usb_mode,
> +	.dr_set = cros_typec_dr_swap,
> +	.pr_set = cros_typec_pr_swap
>  };
>  
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

