Return-Path: <linux-kernel+bounces-847066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D156BC9CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C07425FAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3F1F5827;
	Thu,  9 Oct 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WPKOmEWS"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB21E51E0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023555; cv=none; b=Mng8EMo0g9p0PXXFUeQpQV4EsbvQ0SMG6aP0ONY4Ib0APnAGoAY0bK5cbk0leyZCnuLjakRJ7qLN1XLxGDlQHY/Tnoyp6FCYaK0H3evfoTODnoLQA3yzeiFozOMIxosW9ppRURp+tgFMjuCb8pGise+4eh9R0ohzNerWSaXj/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023555; c=relaxed/simple;
	bh=JsLLQ5yNr+o/mS+W56Z8e89p6lgr5lT4mN5K6n+mRxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIaWHw3Er/CB5ATORdIs9IDAcpyxSLTeh2sZEnPrhQmr5wCwJDwj8Bxc175dlU1DvRL1l+uFkCw3Zo7FuG0TcGCX9vfucq5TTolfTfFGxCO5aU9Cx9FwcVBBW5ClhC5abw1G5mtkITz4OcSa+SPulY6RWbGDA1lh0eT+Tcx8D3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WPKOmEWS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=kOXdFJ3Jdp/tYQ7xod0w/SazY0fKVi5n5IRn+msTeC0=; b=WPKOmEWS8nCZC//B
	+xUZ5Uf+Ffl6TYyMSjSRqUdvUG+yVLdpjntwbKMod7L8MZBE6JkhRa2kFUYAyxYfBThcW29eoPqs+
	zklj1VgxwIgQibtO3O0qbDEyFFNHjf0fgIHk3gZvfVKpdjsycENzk/c/5tKx+Of3iFlCGvkC1epYn
	AMpvvrhGlZ9C+kgTX2uN6MV6X4zvmBPGoHkAMGoN+V70tl33KP/xMIrv4/W7V65CnOspVZr8Z+fy6
	hyF2+hwG3y7Rd1ptRiZyebKY0/CqUNJ99CkVMD9+NxLqujBzWro9b4KOAz0IbcNCubQ9V8PF+S4GB
	zoIM9RM6jmmmbDEolw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1v6sWR-00FWnJ-0M;
	Thu, 09 Oct 2025 15:25:39 +0000
Date: Thu, 9 Oct 2025 15:25:39 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: wcn36xx@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: wcn36xx: Remove unused
 wcn36xx_smd_update_scan_params
Message-ID: <aOfT806hw7l2BeJu@gallifrey>
References: <20250619010506.296494-1-linux@treblig.org>
 <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 15:25:08 up 164 days, 23:38,  1 user,  load average: 0.17, 0.06,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
> On Thu, Jun 19, 2025 at 3:05 AM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> > commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Hi Loic,
  Is this getting into a pull somewhere?

Dave

> 
> > ---
> >  drivers/net/wireless/ath/wcn36xx/smd.c | 60 --------------------------
> >  drivers/net/wireless/ath/wcn36xx/smd.h |  1 -
> >  2 files changed, 61 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> > index 2cf86fc3f8fe..136acc414714 100644
> > --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> > +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> > @@ -1127,66 +1127,6 @@ int wcn36xx_smd_process_ptt_msg(struct wcn36xx *wcn,
> >         return ret;
> >  }
> >
> > -static int wcn36xx_smd_update_scan_params_rsp(void *buf, size_t len)
> > -{
> > -       struct wcn36xx_hal_update_scan_params_resp *rsp;
> > -
> > -       rsp = buf;
> > -
> > -       /* Remove the PNO version bit */
> > -       rsp->status &= (~(WCN36XX_FW_MSG_PNO_VERSION_MASK));
> > -
> > -       if (WCN36XX_FW_MSG_RESULT_SUCCESS != rsp->status) {
> > -               wcn36xx_warn("error response from update scan\n");
> > -               return rsp->status;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -int wcn36xx_smd_update_scan_params(struct wcn36xx *wcn,
> > -                                  u8 *channels, size_t channel_count)
> > -{
> > -       struct wcn36xx_hal_update_scan_params_req_ex msg_body;
> > -       int ret;
> > -
> > -       mutex_lock(&wcn->hal_mutex);
> > -       INIT_HAL_MSG(msg_body, WCN36XX_HAL_UPDATE_SCAN_PARAM_REQ);
> > -
> > -       msg_body.dot11d_enabled = false;
> > -       msg_body.dot11d_resolved = true;
> > -
> > -       msg_body.channel_count = channel_count;
> > -       memcpy(msg_body.channels, channels, channel_count);
> > -       msg_body.active_min_ch_time = 60;
> > -       msg_body.active_max_ch_time = 120;
> > -       msg_body.passive_min_ch_time = 60;
> > -       msg_body.passive_max_ch_time = 110;
> > -       msg_body.state = PHY_SINGLE_CHANNEL_CENTERED;
> > -
> > -       PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
> > -
> > -       wcn36xx_dbg(WCN36XX_DBG_HAL,
> > -                   "hal update scan params channel_count %d\n",
> > -                   msg_body.channel_count);
> > -
> > -       ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
> > -       if (ret) {
> > -               wcn36xx_err("Sending hal_update_scan_params failed\n");
> > -               goto out;
> > -       }
> > -       ret = wcn36xx_smd_update_scan_params_rsp(wcn->hal_buf,
> > -                                                wcn->hal_rsp_len);
> > -       if (ret) {
> > -               wcn36xx_err("hal_update_scan_params response failed err=%d\n",
> > -                           ret);
> > -               goto out;
> > -       }
> > -out:
> > -       mutex_unlock(&wcn->hal_mutex);
> > -       return ret;
> > -}
> > -
> >  static int wcn36xx_smd_add_sta_self_rsp(struct wcn36xx *wcn,
> >                                         struct ieee80211_vif *vif,
> >                                         void *buf,
> > diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
> > index 2c1ed9e570bf..4e39df5589b3 100644
> > --- a/drivers/net/wireless/ath/wcn36xx/smd.h
> > +++ b/drivers/net/wireless/ath/wcn36xx/smd.h
> > @@ -66,7 +66,6 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
> >  int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
> >                           struct ieee80211_vif *vif);
> >
> > -int wcn36xx_smd_update_scan_params(struct wcn36xx *wcn, u8 *channels, size_t channel_count);
> >  int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
> >                               struct cfg80211_scan_request *req);
> >  int wcn36xx_smd_stop_hw_scan(struct wcn36xx *wcn);
> > --
> > 2.49.0
> >
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

