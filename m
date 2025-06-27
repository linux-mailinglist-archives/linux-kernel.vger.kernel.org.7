Return-Path: <linux-kernel+bounces-706792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D7AEBC22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB8B189F763
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B92E92DE;
	Fri, 27 Jun 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZ7A6BEy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419102E88BB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038842; cv=none; b=gRY5dtgwvqpTaUg722mle57GnZmzLrXyczRY5B+oNMR2QagujPIbhU7C3lN3viv9UekL1Ed3eHZPgvm6O/oYA/ZMXReA1YIWw6PR2pr+FozNvdq6EBCe7H8i6IpyRpInyoEyv4pPPJT+CxNeLNhbNy2VADtka83oehhwDS8ZM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038842; c=relaxed/simple;
	bh=uqxNoP0aScxvHUJUFb6AHeHCsVbbhBRCbyQSpDhJLZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLTm8qYDSZJ5u3VC8U4WzTd8LGmxJHx9bNwpFD580424194G3ikswr5+MeRu1HGZgn5i/aKhZMuBcDpz8rECfaBDnl4IKste9SLOk0HVZSrhKbIA9ONioAv+EbsMVDbd9xGZneOOZxLrE2NDsxVDsZB5gTwhmHTthy3Kr3bgahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ7A6BEy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751038840; x=1782574840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uqxNoP0aScxvHUJUFb6AHeHCsVbbhBRCbyQSpDhJLZQ=;
  b=XZ7A6BEy5rO6o6HzZpBFll5kKQ6UJYXoo6qU+hcaXV4k4/0oyoB0ypDl
   x9niHY5iqFt85zqoNAw4YyD17E024LAT396cIX3oT+2QN1oN5TYNjm4o4
   mricuc8ismuVY2rygSSpGiH3emhoT4KhFU3xtNY2ZBoaTpqLwt+w7o/Qi
   mZmyfbcqGS/wo+LYaheJZkJrltB5WY0GnvI5ovfgPtw4fMxHkx+Unhnu5
   60PqgTVEiChHfeZdb98DzARor/9MIE8pFVOuV4l3z4QVrKf/MdPa6aqnX
   gyrLpZKyOQrTjHvzcJtRONeVqESVsMzYUHm/rjY0VSeoep9vG8wwIaxnZ
   g==;
X-CSE-ConnectionGUID: hKkvjks3SzGM7vzLRdOggg==
X-CSE-MsgGUID: iFA4AHLITRSGEg+Byk2vPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="70925825"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="70925825"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 08:40:40 -0700
X-CSE-ConnectionGUID: mFKKxv6IRjWsuzHEsjJFuQ==
X-CSE-MsgGUID: 8MXOkRJHRnKxY6VezkdaBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="158564829"
Received: from opintica-mobl1 (HELO stinkbox) ([10.245.245.146])
  by orviesa005.jf.intel.com with SMTP; 27 Jun 2025 08:40:36 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 27 Jun 2025 18:40:35 +0300
Date: Fri, 27 Jun 2025 18:40:35 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Imre Deak <imre.deak@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Matt Wagantall <mattw@codeaurora.org>,
	Dejin Zheng <zhengdejin5@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] drm/i915/ddi: prefer read_poll_timeout() over
 readx_poll_timeout()
Message-ID: <aF67cxjlfWiWMx-4@intel.com>
References: <cover.1751023767.git.jani.nikula@intel.com>
 <59bcc15dd4debf00ee0c7b430a3b701462ac9de7.1751023767.git.jani.nikula@intel.com>
 <aF6UOCLdO0fGHGA9@intel.com>
 <f922ec0a42855e17228d3f22d7291b389abe2df0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f922ec0a42855e17228d3f22d7291b389abe2df0@intel.com>
X-Patchwork-Hint: comment

On Fri, Jun 27, 2025 at 04:34:23PM +0300, Jani Nikula wrote:
> On Fri, 27 Jun 2025, Ville Syrj�l� <ville.syrjala@linux.intel.com> wrote:
> > On Fri, Jun 27, 2025 at 02:36:32PM +0300, Jani Nikula wrote:
> >> Unify on using read_poll_timeout() throughout instead of mixing with
> >> readx_poll_timeout(). While the latter can be ever so slightly simpler,
> >> they are both complicated enough that it's better to unify on one
> >> approach only.
> >> 
> >> While at it, better separate the handling of error returns from
> >> drm_dp_dpcd_readb() and the actual status byte. This is best achieved by
> >> inlining the read_fec_detected_status() function.
> >> 
> >> Cc: Imre Deak <imre.deak@intel.com>
> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >> ---
> >>  drivers/gpu/drm/i915/display/intel_ddi.c | 33 +++++++++---------------
> >>  1 file changed, 12 insertions(+), 21 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> >> index 0405396c7750..fc4587311607 100644
> >> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> >> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> >> @@ -2339,34 +2339,25 @@ static void intel_dp_sink_set_fec_ready(struct intel_dp *intel_dp,
> >>  		drm_dbg_kms(display->drm, "Failed to clear FEC detected flags\n");
> >>  }
> >>  
> >> -static int read_fec_detected_status(struct drm_dp_aux *aux)
> >> -{
> >> -	int ret;
> >> -	u8 status;
> >> -
> >> -	ret = drm_dp_dpcd_readb(aux, DP_FEC_STATUS, &status);
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> >> -	return status;
> >> -}
> >> -
> >>  static int wait_for_fec_detected(struct drm_dp_aux *aux, bool enabled)
> >>  {
> >>  	struct intel_display *display = to_intel_display(aux->drm_dev);
> >>  	int mask = enabled ? DP_FEC_DECODE_EN_DETECTED : DP_FEC_DECODE_DIS_DETECTED;
> >> -	int status;
> >> -	int err;
> >> +	u8 status = 0;
> >> +	int ret, err;
> >>  
> >> -	err = readx_poll_timeout(read_fec_detected_status, aux, status,
> >> -				 status & mask || status < 0,
> >> -				 10000, 200000);
> >> +	ret = read_poll_timeout(drm_dp_dpcd_readb, err,
> >> +				err || (status & mask),
> >> +				10 * 1000, 200 * 1000, false,
> >> +				aux, DP_FEC_STATUS, &status);
> >
> > I think I hate these macros. It's very hard to tell from this
> > soup what is actually being done here.
> 
> The thing is, I hate __wait_for(), wait_for(), wait_for_us(),
> wait_for_atomic_us(), and wait_for_atomic() even more.
> 
> It's also very hard to figure out what is actually going on with
> them. The timeouts are arbitrarily either ms or us. wait_for_us() is
> atomic depending on the timeout. __wait_for() Wmax parameter actually
> isn't the max sleep, it's 2*Wmax-2. Some of them have exponentially
> growing sleeps, while some arbitrarily don't.
> 
> It's a fscking mess, and people randomly choose whichever version with
> no idea what's actually going on behind the scenes.
> 
> > The 'val', 'op', and 'args' look very disconnected here even though
> > they are always part of the same thing. Is there a reason they can't
> > just be a single 'op' parameter like we have in wait_for() so you can
> > actually see the code?
> >
> > Ie.
> > read_poll_timeout(err = drm_dp_dpcd_readb(aux, DP_FEC_STATUS, &status),
> > 		  err || (status & mask),
> >                   10 * 1000, 200 * 1000, false);
> > ?
> 
> Internally the macro has:
> 
> #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
> 				sleep_before_read, args...) \
> 
> ...
> 
> 		(val) = op(args); \
> 
> So you do need to provide an lvalue val, and you need to be able to add
> () after op. I think GCC allows not passing varargs. IOW you'd need to
> implement another macro (which could be used to implement the existing
> one, but not the other way round).

Just get rid of the 'args' and 'val' and it'll work just fine.
Then it'll be almost identical to wait_for() (basically just missing the
increasing backoff stuff).

AFAICS this thing was originally added just for reading a single
register and checking some bit/etc, so the name made some sense.
But now we're abusing it for all kinds of random things, so even
the name no longer makes that much sense.

So I think just something like this would work fine for us:

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 91324c331a4b..9c38fd732028 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -14,27 +14,24 @@
 #include <linux/io.h>
 
 /**
- * read_poll_timeout - Periodically poll an address until a condition is
- *			met or a timeout occurs
- * @op: accessor function (takes @args as its arguments)
- * @val: Variable to read the value into
- * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
- *            read usleep_range() function description for details and
+ * poll_timeout - Periodically poll and perform an operaion until
+ *                a condition is met or a timeout occurs
+ *
+ * @op: Operation
+ * @cond: Break condition
+ * @sleep_us: Maximum time to sleep between operations in us (0 tight-loops).
+ *            Please read usleep_range() function description for details and
  *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
- * @sleep_before_read: if it is true, sleep @sleep_us before read.
- * @args: arguments for @op poll
+ * @sleep_before_read: if it is true, sleep @sleep_us before operation.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
  *
- * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val. Must not
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  */
-#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
-				sleep_before_read, args...) \
+#define poll_timeout(op, cond, sleep_us, timeout_us, sleep_before_read) \
 ({ \
 	u64 __timeout_us = (timeout_us); \
 	unsigned long __sleep_us = (sleep_us); \
@@ -43,12 +40,12 @@
 	if (sleep_before_read && __sleep_us) \
 		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
 	for (;;) { \
-		(val) = op(args); \
+		op; \
 		if (cond) \
 			break; \
 		if (__timeout_us && \
 		    ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = op(args); \
+			op; \
 			break; \
 		} \
 		if (__sleep_us) \
@@ -58,6 +55,30 @@
 	(cond) ? 0 : -ETIMEDOUT; \
 })
 
+/**
+ * read_poll_timeout - Periodically poll an address until a condition is
+ *                     met or a timeout occurs
+ * @op: accessor function (takes @args as its arguments)
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
+ * @timeout_us: Timeout in us, 0 means never timeout
+ * @sleep_before_read: if it is true, sleep @sleep_us before read.
+ * @args: arguments for @op poll
+ *
+ * When available, you'll probably want to use one of the specialized
+ * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ */
+#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
+			  sleep_before_read, args...) \
+	poll_timeout((val) = op(args), cond, sleep_us, timeout_us, sleep_before_read)
+
 /**
  * read_poll_timeout_atomic - Periodically poll an address until a condition is
  * 				met or a timeout occurs
-- 
2.49.0

-- 
Ville Syrj�l�
Intel

